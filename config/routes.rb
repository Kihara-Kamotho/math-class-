Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "courses#index"
  resources :courses do 
    resources :sections, shallow: true do 
      resources :lessons do 
        resources :comments 
        resources :questions do 
          resources :answers
        end
      end
    end
  end 

  # scope subscriptions under course 
  resources :courses do  
    resources :subscriptions, shallow: true do 
      resources :payments, only: [:index, :new, :create]  
    end
  end

  get '/callback' => 'payments#callback'
end
