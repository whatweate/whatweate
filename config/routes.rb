Rails.application.routes.draw do
  devise_for :users

  resource :profile, except: [:destroy]

  root 'welcome#home'

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_error'
end
