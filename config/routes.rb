Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    member do
      put "like", to: 'posts#upvote'
    end
    resources :comments
  end
  root 'posts#index'
end
