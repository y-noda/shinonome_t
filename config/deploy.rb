# config valid only for current version of Capistrano
lock '3.4.1'

set :application, 'shinonome'
set :repo_url, 'git@bitbucket.org:kew/shinonome.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
ask :branch, 'develop'

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
set :unicorn_config_path, "#{release_path}/config/unicorn/production.rb"

#set :default_env, {
#  rbenv_root: '/usr/local/rbenv',
#  path: '/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH'
#}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :setup do
    on roles(:app) do
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/database.yml', "#{shared_path}/config/database.yml")
      upload!('config/secrets.yml',  "#{shared_path}/config/secrets.yml")
    end
  end

  task :seed do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  task :reset do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:reset db:seed'
        end
      end
    end
  end

  task :restart do
    invoke 'unicorn:restart'
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
