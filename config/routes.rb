Rails.application.routes.draw do
  get 'bookmarks/new' => 'bookmarks#new'
  get 'bookmarks/index' => 'bookmarks#index'
  post 'bookmarks/create' => 'bookmarks#create'
  post 'bookmarks/update', to: 'bookmarks#update'
  get 'bookmarks/destroy' => 'bookmarks#destroy'
  get 'bookmarks/edit' => 'bookmarks#edit'
  root 'bookmarks#index'
end
