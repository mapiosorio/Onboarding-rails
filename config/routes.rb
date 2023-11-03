Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  resources :categories, only: [:index, :show] do
    get :filter_order, on: :member, as: 'filter_order'
 end

  root to: 'categories#index'
end
