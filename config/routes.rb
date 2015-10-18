Rails.application.routes.draw do
  root 'home#index'
  get 'about' => 'home#about'
  get 'privacy' => 'home#privacy'
  get 'latest' => 'home#latest'
  get 'reputation' => 'home#reputation'
  get 'tips' => 'home#tips'
  get 'promo' => 'home#promo'

  resources :stock_images
  resources :phrases do
    resources :phrase_votes
    get :my, on: :collection
  end

  resources :current_conditions  do
    post :save_location, member: true
  end 

  resources :saved_locations, only: [:destroy]
  resource :sessions
  resources :users, only: [:show, :edit, :update] do
    resources :badges, only: [:show]
  end
  resources :contributions, only: [:index]

  resources :schadenfreude
  
  get "/auth/:provider/callback" => "sessions#create"
  get "/auth/failure" => "home#index"

  namespace :api do
    namespace :v1 do
      resources :current_conditions do
        get :forecast
      end
      resources :locations
    end
  end
end
