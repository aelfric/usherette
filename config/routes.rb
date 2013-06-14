Usherette::Application.routes.draw do
  resources :performances
  resources :venues
  resources :shows
  resources :tickets
  resources :carts
end
