Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find_all', to: 'item_search#index'
        get '/find', to: 'item_search#show'
      end 
      resources :items, except: [:new, :edit] do
        get '/merchant', to: 'merchant_items#show'
      end 
      
      namespace :merchants do
        get '/most_revenue', to: 'revenue#most_revenue'
        get '/most_items', to: 'revenue#most_items'
        get '/find_all', to: 'merchant_search#index'
        get '/find', to: 'merchant_search#show'
      end

      resources :merchants, except: [:new, :edit] do
        get '/items', to: 'merchant_items#index'
      end
    end
  end
end
