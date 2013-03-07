# include necessary library
require 'bundler/capistrano' # Give helpers for bundler (gemfile)
require 'capistrano_colors'  # Show colors during deploy

# Correct the bug of debian with the ssh
default_run_options[:pty] = true

# explain to Capistrano where is the ruby environment
set :default_environment, {
  'PATH' => "/home/pi/.gem/ruby/1.9.1/bin/:$PATH"
}
  
# Application set
set :application, "MyHome"
set :repository,  "git@bitbucket.org:ppaques/cemapise.git"
ssh_options[:forward_agent] = true
set :copy_exclude, [".git", "spec"]
set :deploy_to,   "/home/pi/myHome"
set :branch,      "master"
set :deploy_via,  :remote_cache
set :normalize_asset_timestamps, false
set :user,        "pi"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm,         :git
set :use_sudo,    false
set :rails_env,   "production"

# if you are connected with the hotspot wifi
role :web, "www.mydomohome.com"                          # Your HTTP server, Apache/etc
role :app, "www.mydomohome.com"                          # This may be the same as your `Web` server
role :db,  "www.mydomohome.com", :primary => true # This is where Rails migrations will run


# clean up after each deploy
after "deploy:restart",         "deploy:cleanup"
after "deploy:finalize_update", "deploy:symlink_directories_and_files"
after "deploy:create_symlink",  "deploy:resymlink"

# restart the server and make the new link to the database configuration
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Recreate symlink"
  task :resymlink, :roles => :app do
    run "rm -f #{current_path} && ln -s #{release_path} #{current_path}"
  end

  desc 'Symlink shared directories and files'
  task :symlink_directories_and_files do
    run "mkdir -p #{shared_path}/config"
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
