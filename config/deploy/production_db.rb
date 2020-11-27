set :ip, "54.92.18.214"

# EC2のIPアドレス、ユーザ名、サーバのロール、使用するsshキーのPATHを記述
server "#{fetch :ip}",
  user: "ec2-user",
  roles: %w{db},
  ssh_options: {
    keys: %w(/root/.ssh/my-key-5.pem),
    auth_methods: %w(publickey)
    # forward_agent: false,
  }

task :dbtask do
  on roles(:db) do

    execute "sudo service docker start"

    container = capture "docker container ls -a -q -f name=test-db-container"
    if !container.empty?
      execute "docker stop test-db-container"
      execute "docker rm test-db-container"
    end

    execute "docker run --name test-db-container -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mysql:5.7"
  end
end


