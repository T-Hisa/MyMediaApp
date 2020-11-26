set :ip, "46.51.225.108"

# EC2のIPアドレス、ユーザ名、サーバのロール、使用するsshキーのPATHを記述
server "#{fetch :ip}",
  user: "ec2-user",
  roles: %w{app},
  ssh_options: {
    keys: %w(/root/.ssh/my-key-10.pem),
    auth_methods: %w(publickey)
    # forward_agent: false,
  }

task :deploy => :upload do
  appName = fetch :application
  on roles(:app) do
    upload! "config/master.key", "/home/ec2-user/#{appName}/current/config/"
    upload! "config/database.yml", "/home/ec2-user/#{appName}/current/config/"

    execute "sudo service docker start"

    container = capture "docker container ls -q -f name=test-rails-container"
    if !container.empty?
      execute "docker stop test-rails-container"
      execute "docker rm test-rails-container"
    end
    # （ファイル構成が変わったなどで）イメージから削除したい場合は、このコメントアウトを外す。
    image = capture "docker image ls -q test-rails-image"
    if !image.empty?
      execute "docker rmi test-rails-image"
    end

    execute "cd #{appName}/current; docker-compose -f docker-compose_pro.yml run --name test-rails-container -d -p 3000:3000 web"
  end
end


