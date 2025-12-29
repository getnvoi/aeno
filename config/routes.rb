Aeno::Engine.routes.draw do
  root "showcase#index"
  get "showcase/:id", to: "showcase#show", as: :showcase

  namespace :examples do
    resources :contacts
  end

  # Generic confirm dialog
  get "confirm", to: "application#confirm", as: :confirm
end
