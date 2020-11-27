set :ip, "18.178.128.43"

# EC2のIPアドレス、ユーザ名、サーバのロール、使用するsshキーのPATHを記述
server "#{fetch :ip}",
  user: "ec2-user",
  roles: %w{web},
  ssh_options: {
    keys: %w(/root/.ssh/my-key-4.pem),
    auth_methods: %w(publickey)
    # forward_agent: false,
  }

task :sampletask do
  on roles(:web) do
    upload! "./nginx" "/home/ec2-user/nginx"
    execute "sudo service docker start"

    container = capture "docker container ls -a -q -f name=test-nginx-container"
    if !container.empty?
      execute "docker stop test-nginx-container"
      execute "docker rm test-nginx-container"
    end

    execute "docker run --name test-nginx-container -p 80:80 -d test-nginx"
  end
end


