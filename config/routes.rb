Rails.application.routes.draw do
  root 'shifts#show'
  resources :shifts, only: [:show] do
    post :start_visit, on: :member
    post :end_visit, on: :member
  end
end