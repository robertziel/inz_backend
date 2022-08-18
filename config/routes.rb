Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'welcome#index'
  namespace :api, path: '/api' do
    mount RootAPI, at: '/'
    mount GrapeSwaggerRails::Engine => '/docs'
  end
end
