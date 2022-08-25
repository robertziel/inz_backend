set :application, 'inz-backend'
set :repo_url, 'git@github.com:robertziel/inz_backend.git'
set :rvm_type, :user
set :rvm_ruby_version, File.read('.ruby-version').strip

set :scm, :git

set :format, :pretty

set :linked_files, fetch(:linked_files, []).concat(%w(config/database.yml config/secrets.yml .env))
set :linked_dirs, fetch(:linked_dirs, []).concat(%w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads))

set :keep_releases, 5

namespace :deploy do

  after :finishing, 'deploy:cleanup'

end
