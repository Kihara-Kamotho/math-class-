Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
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

  # users
  resources :users

  get '/subscriptions', to: 'subscriptions#all_subscriptions'
  
  # scope subscriptions under course
  resources :courses do
    resources :subscriptions, shallow: true do
      get '/callback' => 'payments#callback'
      post 'payment' => 'payments#create'
      post 'callback' => 'payments#callback'
    end
  end
end
