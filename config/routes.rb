Rails.application.routes.draw do
  
  get "user_profile/advatiser"
  get "user_profile/publisher"

 
 
  get 'links/random', to: 'links#show_random', as: :show_random_links
  get '/link/:id/track', to: 'user_profile#advatiser', as: :track_link

  get "admin/index"
  get 'features', to: 'home#features', as: 'features'  
  get 'pricing', to: 'home#pricing', as: 'pricing'  
  get 'contact', to: 'home#contact', as: 'contact'
  


  
  devise_for :admins
  devise_for :users
  
   
  resources :links do
      member do
        get :visit
      end
  end
  resources :instructions do
  member do
    get :track_click, to: "instructions#track_click", as: :track_click
  end
end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
