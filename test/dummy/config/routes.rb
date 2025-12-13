Rails.application.routes.draw do
  mount Aeros::Engine => "/aeros"

  root to: "components#index"
  get "components/:id", to: "components#show", as: :component
end
