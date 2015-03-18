Rails.application.routes.draw do
  resources :stock_images
  resources :phrases do
    resources :phrase_votes
  end
  resources :current_conditions
  root 'home#index'
end
