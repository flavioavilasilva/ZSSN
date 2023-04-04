Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :reports do
        resources :infected_users, only: [:index]
        resources :not_infected_users, only: [:index]
        resources :average_of_items_by_users, only: [:index]
        resources :lost_points_by_infected_users, only: [:index]
      end
      resources :barters, only: [:create]
      resources :users do
        resources :items
        resources :infected_alerts
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
