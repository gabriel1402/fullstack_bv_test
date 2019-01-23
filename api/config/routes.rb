Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'url', to: 'url#create'
  get 'top',  to: 'url#top_100'
  get '/:id', to: 'url#redirect'
end
