Rails.application.routes.draw do
  resources :stock_images
  resources :phrases
  resources :current_conditions
  root 'home#index'
end
