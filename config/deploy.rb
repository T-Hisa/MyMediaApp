# capistranoのバージョン指定
lock "~> 3.14.1"

# アプリケーション名
set :application, "myFirstPortfolio"

# cloneするgitのリポジトリ
set :repo_url, "git@github.com:T-Hisa/myFirstPortfolio.git"

# デプロイするブランチ。
set :branch, 'master'

# デプロイ先のディレクトリ
set :deploy_to, '/var/www/myFirstPortfolio'

# EC2のNginx用インスタンスに、 "web"roleを割り当てる。
role :web, "~"
# EC2のMySQL用インスタンス・puma用インスタンスも同様
role :db, "~"
role :app, "~"


task :update do
  run_locally do
    application = fetch :application
    if test "[ -d #{application} ]"
      execute "cd #{application}; git pull"
    else
      execute "git clone #{fetch :repo_url} #{application}"
    end
  end
end

# タスクarchiveの前にupdateを実行する。
task :archive => :update do
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

# ログの出力されるフォーマットを設定している。デフォルトは[airbrussh](https://github.com/mattbrictson/airbrussh)というライブラリ
# Default value for :format is :airbrussh.
# set :format, :airbrussh

# [airbrussh](https://github.com/mattbrictson/airbrussh)のログの設定可能項目を指定している。こちらもデフォルトのまま。
# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# ptyは、仮想端末(ターミナル)の割り当てフラグ。
# このフラグがtrueだと、実行中にターミナルを閉じても動作する。はず。
# Default value for :pty is false
# set :pty, true

# > Can be used for persistent configuration files like database.yml. See Structure for the exact directories
# 指定されたファイルは、展開中にアプリケーションの共有フォルダから各リリースディレクトリにシンボリックリンクされる。
# ??? なんかよくわからないけど、例にあるdatabase.ymlなどのgithubに公開したくない、かつ サーバにアップロードしたいファイルがある場合は指定するのかな？
# Default value for :linked_files is []
# append :linked_files, "config/database.yml"


# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# 公式サイトによると、Capistranoは
# > By default Capistrano always assigns a non-login, non-interactive shell.
# であるらしく、.bash_profile等のファイルが読み込まれないため、ローカルの環境変数が使えない。
# そこで、この『default_env』には、『設定したい環境変数』を設定できるということ。
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }


# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
