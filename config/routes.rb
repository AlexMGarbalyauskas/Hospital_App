Rails.application.routes.draw do
  resources :patients


  get "about", to: "about#index"
  get 'select_category', to: 'patients#select_category', as: :select_patient_category



  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create" 
  
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create" 

  
  delete "logout", to: "sessions#destroy" 


  root to: "main#index"

end
