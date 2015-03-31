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

  resources :current_conditions  do
    post :save_location, member: true
  end 

  resources :saved_locations, only: [:destroy]
  resource :sessions
  resources :users, only: [:show, :edit, :update] do
    resources :badges, only: [:show]
  end
  resources :contributions, only: [:index]
  get "/auth/:provider/callback" => "sessions#create"

  namespace :api do
    namespace :v1 do
      resources :current_conditions do
        get :forecast, member: true
      end
    end
  end
end
