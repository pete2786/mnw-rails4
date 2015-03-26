Rails.application.routes.draw do
  root 'home#index'
  get 'about' => 'home#about'
  get 'privacy' => 'home#privacy'
  get 'latest' => 'home#latest'
  get 'reputation' => 'home#reputation'

  resources :stock_images
  resources :phrases do
    resources :phrase_votes
  end
  resources :current_conditions  
  resource :sessions
  resources :users, only: [:show, :edit, :update]
  resources :contributions, only: [:index]
  get "/auth/:provider/callback" => "sessions#create"
end
