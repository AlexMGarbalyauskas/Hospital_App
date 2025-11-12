# config/routes.rb
#routes for all my pages in views 

Rails.application.routes.draw do
 

  #root page stating page
  root "home#index"


  #deletion of multiple patients
  resources :patients do
    collection do
      delete :delete_multiple
    end
  end

  

  # Map API page with google maps and vaccine data for each country
  #views/map/api_page.html.erb
  get "map/api", to: "map#api_page", as: :map_api

  # API 2 timeline of covid 
  #views/api_page/index.html.erb
  get "api_page", to: "api_page#index", as: :api_page

  #API 3 global covid 
  #views/global_covid/index.html.erb
  get 'global_covid', to: 'global_covid#index', as: 'global_covid'

  # Auth routes 
  get "sign_up", to: "users#new", as: :sign_up
  post "sign_up", to: "users#create"
  get "sign_in", to: "sessions#new", as: :sign_in
  post "sign_in", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

  #About route page 
  get "about", to: "pages#about", as: :about
  get "up", to: "rails/health#show", as: :rails_health_check
end
