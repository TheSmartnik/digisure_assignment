Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resource :user, only: %i[show create]
  resource :auth, only: :create, controller: :auth
  resources :transactions
end
