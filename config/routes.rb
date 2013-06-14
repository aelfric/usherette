Usherette::Application.routes.draw do
  resources :performances
  resources :venues
  resources :shows
  resources :tickets
  resources :carts
  resources :payment_notifications
end
