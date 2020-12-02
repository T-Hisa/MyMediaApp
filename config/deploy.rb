# capistranoのバージョン指定
lock "~> 3.14.1"

# アプリケーション名
set :application, "myFirstPortfolio"
# デプロイしたサーバで参照するgitのリポジトリ。
set :repo_url, "git@github.com:T-Hisa/myFirstPortfolio.git"
# デプロイするブランチ。デフォルトでmasterブランチ。なのでここでは、未指定。
# set :branch, 'master'
# デプロイ先のディレクトリ
set :deploy_to, "/home/ec2-user/#{fetch :application}"
# ptyは、仮想端末(ターミナル)の割り当てフラグ。
# このフラグがtrueだと、実行中にターミナルを閉じても動作する?。
# sudoをつけてコマンドを実行するのに必要。
# Default value for :pty is false
set :pty, true


set :shared_path, "/home/ec2-user/#{fetch :application}/shared/"

# > Can be used for persistent configuration files like database.yml. See Structure for the exact directories
# 指定されたファイルは、展開中にアプリケーションの共有フォルダから各リリースディレクトリにシンボリックリンクされる。
# ??? なんかよくわからないけど、例にあるdatabase.ymlなどのgithubに公開したくない、かつ サーバにアップロードしたいファイルがある場合は指定するのかな？
# Default value for :linked_files is []
# append :linked_files, "config/database.yml"
# ln -s deploy_to/shared/config/database.yml と同義?
# set :linked_files, fetch(:linked_files, []).push('config/settings.yml')
# set :linked_files, %w[config/master.key]
set :linked_files, %w[.env]

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')
# set :linked_dirs, %w[ log tmp/pids tmp/cache tmp/sockets]


# 何世代前までリリースを残しておくか
# Default value for keep_releases is 5
set :keep_releases, 5

# ログの出力されるフォーマットを設定している。デフォルトは[airbrussh](https://github.com/mattbrictson/airbrussh)というライブラリ
# Default value for :format is :airbrussh.
# set :format, :airbrussh

# [airbrussh](https://github.com/mattbrictson/airbrussh)のログの設定可能項目を指定している。こちらもデフォルトのまま。
# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# 公式サイトによると、Capistranoは
# > By default Capistrano always assigns a non-login, non-interactive shell.
# であるらしく、.bash_profile等のファイルが読み込まれないため、ローカルの環境変数が使えない。
# そこで、この『default_env』には、『設定したい環境変数』を設定できるということ。
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :default_env, { path: "usr/local/bundle/bin:$PATH"}

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }


# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
