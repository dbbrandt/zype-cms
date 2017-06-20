Rails.application.routes.draw do

  root 'static_pages#index'

  get 'video/:id', to: 'static_pages#show', as: 'show'

  get '/pages/:page', to: 'static_pages#page', as: 'pages'

  post "/login" => "static_pages#login"

  get "/logout" => "static_pages#logout"

  namespace :admin do
  end
  # mount Fae below your admin namespec
  mount Fae::Engine => '/admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
