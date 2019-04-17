Rails.application.routes.draw do

resources :communities do
	collection do
		get 'public',to:'communities#public'
		get 'private',to:'communities#private_club'
		get 'owned',to:'communities#owned_club'
	end
	member do 
		post 'join',to:'communities#join_public'
	end
end
  
resources :profile, except: [:new, :create, :edit, :update, :destroy, :index, :show] do
	collection do
	  patch 'update'
	  get 'edit'
	  get 'show'
	  post 'update_bio'
	  get "profile_image_carousel",as:"profile_carousel"
	  post "image",as:'image_upload'
	  get 'close_carousel',as:"close_carousel"
	  post 'dp/:id',to:'profile#make_dp',as:"make_profile_image"
	end
end

  devise_for :users
  resources :blogs
  root "blogs#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
