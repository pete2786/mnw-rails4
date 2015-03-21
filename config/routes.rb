Rails.application.routes.draw do
  root 'home#index'
  get 'about' => 'home#about'
  get 'privacy' => 'home#privacy'

  resources :stock_images
  resources :phrases do
    resources :phrase_votes
  end
  resources :current_conditions  
  resource :sessions
  get "/auth/:provider/callback" => "sessions#create"
end
