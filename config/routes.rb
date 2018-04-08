Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'kb', to: 'pages#kb'
  get 'kb/article-a' , to: 'pages#articlea'
  get 'kb/article-b' , to: 'pages#articleb'
  get 'kb/test/article-c' , to: 'pages#articlec'
  get 'kb/test' , to: 'pages#test'
  resources :articles do
    collection { post :import }
  end
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users, except: [:new]
  resources :categories
  namespace :api do
    resources :articles
  end

end
