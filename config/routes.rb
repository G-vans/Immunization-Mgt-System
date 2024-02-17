Rails.application.routes.draw do
  get 'dashboard/index'
  # resources :immunization_schedules
  # get 'home/index'
  devise_for :medics
  resources :vaccines
  # resources :children

  resources :immunization_schedules, only: [:index, :new, :create, :show, :edit, :destroy] do
    member do
      patch 'update_status'
    end
  end

  resources :children do
    resources :immunizations
    resources :immunization_schedules do
      member do
        patch 'update_status' # Nested under `immunization_schedules` for updating immunization schedules
        post 'follow_up_call'
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
  
end
