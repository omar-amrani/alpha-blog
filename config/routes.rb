Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'kb', to: 'pages#kb'
  get 'kb/article-a' , to: 'pages#articlea'
  get 'kb/article-b' , to: 'pages#articleb'
  resources :articles
end
