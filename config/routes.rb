Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "courses#index"
  resources :courses do 
    resources :sections, shallow: true do 
      resources :lessons 
    end
  end 
end
