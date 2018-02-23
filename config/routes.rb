Rails.application.routes.draw do
  root "static_pages#index"

  post "sign_in", to: "sessions#create", as: :sign_in
  post "sign_out", to: "sessions#destroy", as: :sign_out
end
