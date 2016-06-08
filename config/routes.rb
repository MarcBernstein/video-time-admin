Rails.application.routes.draw do
 
  post 'messages/copy'

  resources :messages
 
  root 'welcome#index'
end
