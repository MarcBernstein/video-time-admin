Rails.application.routes.draw do
 
  resources :messages
 
  root 'welcome#index'
end
