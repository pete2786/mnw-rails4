Rails.application.routes.draw do
  resources :stock_images
  resources :phrases do
    get :location, on: :collection
  end
end
