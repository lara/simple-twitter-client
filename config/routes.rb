Rails.application.routes.draw do
  root "static_pages#index"

  get "/auth/twitter/callback", to: "sessions#create"
  post "sign_in", to: "sessions#create", as: :sign_in
  post "sign_out", to: "sessions#destroy", as: :sign_out
end
