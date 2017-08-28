Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations", confirmations: "confirmations" }

  devise_scope :user do
    authenticated :user do
      root "home#index", as: :authenticated_root
    end

    unauthenticated do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :posts, except: [:index, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :users, only: [:show, :edit]
  get "/pages/:page" => "pages#show"

end
