Rails.application.routes.draw do
  # Merchants
  namespace :api do
    namespace :v1 do
      # Nested Merchant ~ Non RESTful
      namespace :merchants do
        # Merchants by most Items sold
        resources :most_items, only: [:index], controller: :most_items
        # Merchant Search
        resources :find, only: [:index], controller: :search
      end
      # Nested Item ~ Non RESTful 
      namespace :items do
        # Item Search
        resources :find_all, only: [:index], controller: :search
      end
      # Merchant_Items
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end
      # Items
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: [:index], controller: :items_merchant
      end
      # Revenue ~ Non RESTful
      namespace :revenue do
        # Potential Revenue of Unshipped Orders
        resources :unshipped, only: [:index], controller: :orders
        # Total Revenue for Merchant & Merchants by Most Revenue
        resources :merchants, only: [:index, :show], controller: :merchant
      end
    end
  end
end
