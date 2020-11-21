set :ip, "54.168.206.234"

# EC2のIPアドレス、ユーザ名、サーバのロール、使用するsshキーのPATHを記述
server "#{fetch :ip}",
  user: "ec2-user",
  roles: %w{app},
  ssh_options: {
    keys: %w(/root/.ssh/my-key-6.pem),
    auth_methods: %w(publickey)
    # forward_agent: false,
  }

# task :update do
#   run_locally do
#     execute "mv .ssh .rspec test ../"

#   end
# end

# task :archive do
#   application = fetch :application
#   run_locally do
#     # execute "uptime"
#     pwd = capture "pwd"
#     info pwd
#     execute "cd ../; tar -cvzf my_app.tgz sample"
#   #   # execute "cd ../"
#   # end


#     # execute "cd ../; tar -cvzf my_app.tgz #{application}"
#     archive_name = "my_app.tgz"
#     # path = "../"
#     archive_path = "../#{archive_name}"
#     upload_path = "/home/ec2-user/#{application }"
#     info archive_name
#     # debug upload_path
#     set :archive_name, archive_name
#     set :archive_path, archive_path
#     set :upload_path, upload_path
#   end
# end

# task :deploy do
  # run_locally do
  # capture "tar -cvzf my_app.tgz ../sample"
  #   info archive_name
  # end
# task :deploy => :archive do
#   archive_name = fetch :archive_name
#   archive_path = fetch :archive_path
#   upload_path = fetch :upload_path
#   # run_locally do 
#   #   upload! archive_path, upload_path
#   # end

#   # on roles(:app) do
#   #   unless test "[ -d #{ upload_path } ]"
#   #     execute "mkdir -p #{ upload_path }"
#   #   end
#   #   upload! archive_name, upload_path
#   #   # execute "cd #{upload_path}; tar -zxvf #{archive_name}"
#   #   # execute "docker build -t rails-image ."
#   #   # execute "docker run -p 3000:3000 --name production-rails rails-image puma -C config/puma.rb -e production"
#   # end
# end


