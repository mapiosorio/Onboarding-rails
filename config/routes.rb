Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  resources :categories, only: [:index, :show] do
    get :filter_order, on: :member
 end
  resources :products, only: [:show]
  resources :orders, only: [:new, :create] do
    get :additional_information, on: :new
  end

  root to: 'categories#index'
end
