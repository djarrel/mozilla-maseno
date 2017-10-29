Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/sign_up', to: 'users#new'

  resources :users
end
