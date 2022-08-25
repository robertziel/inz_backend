mydevil_domain = 'x'
mydevil_user = 'x'
ssh_address = "#{mydevil_user}@#{mydevil_domain}"

set :stage, :production

set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

set :deploy_to, '/home/robertz/domains/inz-backend.robertz.co'

server mydevil_domain, user: mydevil_user, roles: %w{web app db}, primary: true

set :rails_env, :production

set :branch, 'master'

set :bundle_config, { deployment: false }
# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
role :app, [ssh_address]
role :web, [ssh_address]
role :db,  [ssh_address]

Rake::Task["passenger:restart"].clear_actions

# MyDevil.net custom operations
namespace :deploy do
  # link app to location required by mydevil.net
  after :published, :symlink_to_public_ruby do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute "rm -r #{fetch(:deploy_to)}/public_ruby"
      execute "ln -s #{fetch(:release_path)} #{fetch(:deploy_to)}/public_ruby"
    end
  end
  # automatically restart app after deploy
  after :published, :restart_app do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      execute "devil www restart inz-backend.robertz.co"
    end
  end

  desc 'db_seed must be run only one time right after the first deploy'
  task :db_seed do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
end
