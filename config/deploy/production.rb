# set :ip, "46.51.225.108"
set :ip, "35.72.220.187"

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
  shared_path = fetch :shared_path
  on roles(:app) do
    unless test "[ -f #{shared_path}/.env-pro ]"
      upload! ".env", "#{shared_path}/.env-pro"
    end
  end
end

task deploy: :upload do
  release_path = fetch :release_path
  on roles(:app) do
    # upload! "config/master.key", "#{release_path}/config/"
    execute "sudo service docker start"
    execute "cp #{release_path}/.env-pro #{release_path}/.env;"

    # container = capture "docker container ls -a -q -f name=test-rails-container"
    # if !container.empty?
    #   execute "docker stop test-rails-container"
    #   execute "docker rm test-rails-container"
    # end
    # image = capture "docker image ls -q test-rails-image"
    # if !image.empty?
    #   execute "docker rmi test-rails-image"
    # end

    # execute "docker-compose -f #{release_path}/docker-compose_pro.yml up -d"
    # execute "docker-compose up -d"
  end
end


