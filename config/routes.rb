Rails.application.routes.draw do
  post "sign_in", to: "sessions#create"
  post "sign_up", to: "registrations#create"
  delete 'sessions/current', to: 'sessions#destroy_current'
  resources :sessions, only: [:index, :show, :destroy]
  resource  :password, only: [:edit, :update]
  namespace :identity do
    resource :email,              only: [:edit, :update]
    resource :email_verification, only: [:show, :create]
    resource :password_reset,     only: [:new, :edit, :create, :update]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/profile", to: "profiles#show"

  namespace :api do
    namespace :v1 do
      resources :branches, only: [:index, :show, :create, :update, :destroy]
      resources :law_offices, only: [:index, :show, :create, :update, :destroy]
      resources :contact_messages, only: [:create]
      resources :users, only: [:create, :index, :show, :update, :destroy]
      get "me", to: "users#me", as: "me"

      resources :categories, only: [:index, :show, :create, :update, :destroy]
      resources :articles, only: [:index, :show, :create, :update, :destroy], param: :slug

      namespace :public do
        resources :lawyers, only: [:index]
        resources :articles, only: [:index, :show]
      end
    end
  end

  # namespace :api do
  #   namespace :v1 do
  #     namespace :public do
  #       resources :lawyers, only: [:index]
  #     end
  #   end
  # end

  # Defines the root path route ("/")
  # root "posts#index"
end
