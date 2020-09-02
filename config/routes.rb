Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :items, except: [:new, :edit] do
        get '/merchant', to: 'merchant_items#show'
      end 
      resources :merchants, except: [:new, :edit] do
        get '/items', to: 'merchant_items#index'
      end 
    end
  end
end
