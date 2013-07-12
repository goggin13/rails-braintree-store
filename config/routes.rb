Rails3BootstrapDeviseCancan::Application.routes.draw do
  get "payments/show"

  get "payments/new"

  get "payments/create"

  resources :products


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end