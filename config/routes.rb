Rails.application.routes.draw do
  get 'home/index'
  post 'home/index'

  #get 'welcome/index'

  get '/auth/spotify/callback', to: 'users#spotify'

  root 'welcome#index'
  # You can have the root of your site routed with "root"
  # root 'welcome#index'

end
