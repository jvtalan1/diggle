Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  devise_scope :user do
    authenticated :user do
      root "posts#index", as: :authenticated_root
    end

    unauthenticated do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :posts, except: [:edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :users, only: [:show]

end
