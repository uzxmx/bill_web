Rails.application.routes.draw do
  namespace :api do
    scope :users, controller: :users do
      post :sign_in
      get :me
    end

    resources :workspaces do
      collection do
        post :join
      end
    end
    resources :workspace_requests
    resources :cargoes
    resources :cargo_categories do
      member do
        post :update_count
      end
    end
    resources :bills
    resources :upload_tokens
    resources :tags
  end
end
