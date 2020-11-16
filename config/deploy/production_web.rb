# EC2のwebサーバのインスタンスのIPアドレスを変数web_ipに格納
set :web_ip, ""

# EC2のIPアドレス、ユーザ名、サーバのロール、使用するsshキーのPATHを記述
server "#{fetch :web_ip}",
  user: "ec2-user",
  roles: %w{web},
  ssh_options: {
    keys: %w(~/my-key-2.pem),
    auth_methods: %w(publickey)
    # forward_agent: false,
  }


task :update_web do
  run_locally do
    application = fetch :application
    if test "[ -d #{application} ]"
      execute "cd #{application}; git pull"
    else
      execute "git clone #{fetch :repo_url} #{application}"
    end
  end
end

# タスクarchive_webの前にupdate_webを実行する。
task :archive_web => :update_web do
  run_locally do
    sbt_output = capture "cd #{fetch :application}; sbt pack-archive"

    sbt_output_without_escape_sequences = sbt_output.lines.map { |line| line.gsub(/\e\[\d{1,2}m/, '') }.join

    archive_relative_path = sbt_output_without_escape_sequences.match(/\[info\] Generating (?<archive_path>.+\.tar\.gz)\s*$/)[:archive_path]
    archive_name = archive_relative_path.match(/(?<archive_name>[^\/]+\.tar\.gz)$/)[:archive_name]
    archive_absolute_path = File.join(capture("cd #{fetch(:application)}; pwd").chomp, archive_relative_path)

    info archive_absolute_path
    info archive_name

    set :archive_absolute_path, archive_absolute_path
    set :archive_name, archive_name
  end
end

task :deploy => :archive do
  archive_path = fetch :archive_absolute_path
  archive_name = fetch :archive_name
  release_path = File.join(fetch(:deploy_to), fetch(:application))

  on roles(:web) do
    begin
      old_project_dir = File.join(release_path, capture("cd #{release_path}; ls -d */").chomp)
      if test "[ -d #{old_project_dir} ]"
        running_pid = capture("cd #{old_project_dir}; cat RUNNING_PID")
        execute "kill #{running_pid}"
      end
    rescue => e
      info "No previous release directory exists"
    end
    
    unless test "[ -d #{release_path} ]"
      execute "mkdir -p #{release_path}"
    end

    upload! archive_path, release_path

    execute "cd #{release_path}; tar -zxvf #{archive_name}"

    project_dir = File.join(release_path, capture("cd #{release_path}; ls -d */").chomp)

    launch = capture("cd #{project_dir}; ls bin/*").chomp

    execute "cd #{project_dir}; ( ( nohup #{launch} &>/dev/null ) & echo $! > RUNNING_PID)"
  end
end  

# デプロイ対象のサーバにログインする際のsshキーのPATHを記述

#  set :ssh_options, {
#    keys: %w(/home/user_name/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }



# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/user_name/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
