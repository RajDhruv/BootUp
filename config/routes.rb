Rails.application.routes.draw do
  patch 'profile/update'
  get 'profile/edit'
  get 'profile/show'
  post 'profile/update_bio'
  post '/example',to:"profile#image"
  devise_for :users
  resources :blogs
  root "blogs#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
