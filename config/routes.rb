#Rails routing system 
#Maps HTTP verbs and URLs to controller actions 

#Auto generates RESTful routes for patients resource 
Rails.application.routes.draw do
  
  #Patients resource with all CRUD actions 
  resources :patients

  #Sets homepage to main controller index action
  get "about", to: "about#index"

  #Custom route for selecting patient category before creating a new patien 
  get 'select_category', to: 'patients#select_category', as: :select_patient_category

  #Two routes for user registration (sign-up and sign-in) 
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create" 
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create" 

  #Route for user logout
  delete "logout", to: "sessions#destroy" 
  
  #Set the homepage of the application
  root to: "main#index"

end
