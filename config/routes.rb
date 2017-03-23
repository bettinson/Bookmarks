Rails.application.routes.draw do
  get 'tags/index'

  get 'tags/show'

  get 'bookmarks/new' => 'bookmarks#new'
  get 'bookmarks/index' => 'bookmarks#index'
  post 'bookmarks/create' => 'bookmarks#create'
  post 'bookmarks/update', to: 'bookmarks#update'
  get 'bookmarks/destroy' => 'bookmarks#destroy'
  get 'bookmarks/edit' => 'bookmarks#edit'
  get 'bookmarks/view' => 'bookmarks#show'
  delete 'bookmarks/' => 'bookmarks#destroy'
  post 'bookmarks/react' => 'bookmarks#react'
  root 'bookmarks#index'

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users
end
