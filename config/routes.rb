Rails.application.routes.draw do


  root to: 'public/homes#top'

  namespace :public do
    resources :posts, only: [:new, :show, :index, :create, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
    end
    resources :customers, only: [:index, :show, :edit, :update]
    resources :tags do
      get 'posts', to: 'posts#search'
    end
    get 'events/search/sort_new', to: 'events#search', as: 'sort_new'
    get 'events/search/sort_old', to: 'events#search', as: 'sort_old'
  end

  namespace :master do
    resources :posts, only: [:index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:destroy]
    end
    resources :customers, only: [:index, :show, :edit, :update,]
    resources :tags do
      get 'posts', to: 'posts#search'
    end
  end

  devise_for :masters,controllers: {
    sessions: "master/sessions"
  }

  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'public/passwords'
  }
  devise_scope :customer do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end