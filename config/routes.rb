Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations", confirmations: "confirmations" }

  devise_scope :user do
    authenticated :user do
      root "home#index", as: :authenticated_root
      match "/profile/edit", to: "registrations#profile", as: :edit_profile, via: [:get, :post]
      match "/refresh_users", to: "home#refresh_users", as: :refresh_users, via: [:get]
    end

    unauthenticated do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :posts, except: [:index, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :users, only: [:show]
  get "/pages/:page", to: "pages#show", as: :page

end
