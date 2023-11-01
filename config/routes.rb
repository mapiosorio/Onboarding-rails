Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  resources :categories, only: [:index, :show] do
    get :filter_order, on: :member
 end
  resources :products, only: [:show]
  root to: 'categories#index'
end
