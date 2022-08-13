Rails.application.routes.draw do


  root to: 'public/homes#top'
  get "public/home/about"=>"public/homes#about"

  namespace :public do
    resources :posts, only: [:index, :show, :new, :create, :edit, :update]
    get "customer/mypage"=>"customers#show"
    resource :customers, only: [:edit, :update]
  end

  namespace :master do
    resources :posts, only: [:index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end
  devise_for :masters,controllers: {
    sessions: "master/sessions"
  }

  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'public/passwords'
  }
  devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end