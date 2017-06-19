Rails.application.routes.draw do

  root "static_pages#index"

  get "video/:id" => "static_pages#show"

  get "/pages/:page" => "static_pages#page"

  namespace :admin do
  end
  # mount Fae below your admin namespec
  mount Fae::Engine => '/admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
