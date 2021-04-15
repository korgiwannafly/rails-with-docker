Rails.application.routes.draw do
  root 'home#index'
  
  get '/post', to: 'home#post'
  get '/', to: 'home#index'
end
