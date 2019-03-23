Rails.application.routes.draw do
  patch 'profile/update'
  get 'profile/edit'
  get 'profile/show'
  get 'image/carousel',to:"profile#profile_image_carousel",as:"profile_carousel"
  post '/example',to:"profile#image"
  post '/profile/dp/:id',to:'profile#make_dp',as:"make_profile_image"
  get '/carousel/close',to:'profile#close_carousel',as:"close_carousel"
  devise_for :users
  resources :blogs
  root "blogs#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
