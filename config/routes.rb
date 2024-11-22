Rails.application.routes.draw do
  devise_for :users
  
  resources :categories
  
  resources :posts do
    resources :comments, only: [:create]
    collection do
      get 'all', to: 'posts#all_posts'
    end
  end

  root 'posts#index'
end
