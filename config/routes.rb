Rails.application.routes.draw do
  resources :armor
  resources :weapons
  root 'home#index', as: 'home_index'
  resources :conditions
  resources :spells
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
