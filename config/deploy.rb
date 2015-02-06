# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'my_app_name'
set :repo_url, 'git@github.com:lvalenzuela/kongo_project.git'
set :deploy_to, '/var/www/html/kongo_test'
set :scm, :git
set :branch, "master"
set :user, "ubuntu"
set :group, "deployers"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :ssh_options, { :forward_agent => true }
set :keep_releases, 5
default_run_options[:pty] = true
server "54.205.104.136", :app, :web, :db, :primary => true

set :rvm_ruby_string, :local        # use the same ruby as used locally for deployment

before "deploy:assets:precompile" do
  run ["ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml",
       "ln -nfs #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml",
       "ln -fs #{shared_path}/uploads #{release_path}/uploads"
  ].join(" && ")
end

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

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
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
