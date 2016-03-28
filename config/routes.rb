Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users

  resources :tweets, only: [:index] do
    collection do
      get :recent_tweets
      get :autocomplete
    end
  end
end
