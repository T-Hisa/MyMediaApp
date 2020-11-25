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

task :upload do
  applicationName = fetch :application
  shared_path = "/home/ec2-user/#{applicationName}/shared"

  on roles(:app) do
    upload! "config/database.yml", "#{shared_path}/config"
    upload! "config/master.key", "#{shared_path}/config"
    # upload! "config/"
  end
end


task :deploy => :upload do
  applicationName = fetch :application
  on roles(:app) do
    # upload! database_path, shared_path
    # execute ""
    execute "service docker start"
    execute "cd #{applicationName}/current; docker-compose run web"
    # execute "cd #{upload_path}; tar -zxvf #{archive_name}"
    # execute "docker build -t rails-image ."
    # execute "docker run -p 3000:3000 --name production-rails rails-image puma -C config/puma.rb -e production"
  end
end


