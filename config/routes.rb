# config/routes.rb
Rails.application.routes.draw do
 
  root "home#index"

  resources :patients do
    collection do
      delete :delete_multiple
    end
  end

  

  # Map / API page
 
  get "map/api", to: "map#api_page", as: :map_api
  get "api_page", to: "api_page#index", as: :api_page





  
  

  # Auth routes...
  get "sign_up", to: "users#new", as: :sign_up
  post "sign_up", to: "users#create"
  get "sign_in", to: "sessions#new", as: :sign_in
  post "sign_in", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

  get "about", to: "pages#about", as: :about
  get "up", to: "rails/health#show", as: :rails_health_check
end
