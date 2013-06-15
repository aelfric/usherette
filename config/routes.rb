Usherette::Application.routes.draw do
    root :to => 'performances#index'
  resources :performances
  resources :venues
  resources :shows
  resources :tickets
  resources :carts
  resources :payment_notifications
end
