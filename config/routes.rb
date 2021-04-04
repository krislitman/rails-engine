Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Merchants
  namespace :api do
    namespace :v1 do
      # Merchant Search
      namespace :merchants do
        resources :find, only: [:index], controller: :search
      end
      # Item Search
      namespace :items do
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
    end
  end
end
