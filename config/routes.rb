Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: redirect(path: 'login')
  # root to: redirect(path: 'encrypt')
  resources :encrypt
  resources :decrypt
  resources :view, only: [:show]
  resources :users, only: [:create, :new]
  post '/download', to: 'view#download'
  get '/login', to: 'sessions#new'
  post '/create', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
