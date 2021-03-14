Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: redirect(path: 'encrypt')
  resources :encrypt, only: [:index]
  resources :decrypt
  resources :view, only: [:show]
  post '/download', to: 'view#download'
end
