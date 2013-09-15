Usherette::Application.routes.draw do
  resources :messages, :only => [:new, :create]
  devise_for :users

    root :to => 'performances#index'
  resources :performances
  resources :venues
  resources :shows
  resources :tickets
  resources :carts
  resources :payment_notifications
  match 'shows/:id/will_call' => 'shows#will_call'
  match 'shows/:id/reserve' => 'shows#reserve'
  match 'about' => 'messages#about'
end
