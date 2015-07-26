Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#index'

  get "/when" => 'application#when'
  get "/where" => 'application#where'
  get "/gifts" => 'application#gifts'

  resources :rsvps, only: [:new, :create, :index, :update], path: 'rsvp' do
    member do
      get :thank_you
    end

    collection do
      get :coming_soon
    end
  end

  resources :photos, only: [:index]
  
  get "admin/:password", to: "rsvps#list"

end
