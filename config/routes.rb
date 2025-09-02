Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  namespace :api do
    namespace :v1 do
      resources :stores, only: [ :index, :show ]
      resources :products, only: [ :index, :show ]
      resources :shopping_lists do
        resources :shopping_list_items, only: [ :create, :update, :destroy ]
        get "optimized_order", on: :member
      end

      post "login", to: "auth#login"
      post "register", to: "auth#register"
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
