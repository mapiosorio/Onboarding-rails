Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  get 'category/:id', to: 'categories#show', as: 'category'
  get 'category/:id/order', to: 'categories#order', as: 'order'
  get 'category/:id/filter', to: 'categories#filter', as: 'filter'
  get 'category', to: 'categories#index'

  root to: 'categories#index'
end
