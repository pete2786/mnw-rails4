set :application, "mnw-rails4"
set :repository, Rails.application.secrets.github_repo
set :user, "deploy"
set :rvm_type, :system

require "bundler/capistrano"
require "rvm/capistrano"

set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, Rails.application.secrets.deploy_directory
set :use_sudo, false


role :web, Rails.application.secrets.deploy_server
role :app, Rails.application.secrets.deploy_server
role :db,  Rails.application.secrets.deploy_server, :primary => true # This is where Rails migrations will run

before 'deploy:restart', "deploy:copy_config"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
 
 task :copy_config do
   run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
   run "cp #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
 end
end
