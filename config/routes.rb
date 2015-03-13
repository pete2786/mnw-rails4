Rails.application.routes.draw do
  resources :stock_images
  resources :phrases do
    get :by_location, on: :collection
  end
end
