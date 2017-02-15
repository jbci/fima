Rails.application.routes.draw do
  resources :evaluations
  get 'evals_by_indicator', to:'evaluations#evals_by_indicator'
  resources :posts
  resources :areas
  resources :area_levels
  devise_for :admins
  get 'home/index'
  root to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :backend

  get 'get_informed', to:'home#get_informed'
  get 'initiatives', to:'home#initiatives'

  get 'backend/posts', to:'backend#posts'
  get 'backend/areas', to:'backend#areas'
  get 'backend/evaluations', to:'backend#evaluations'
  get 'backend/rating_definition', to:'backend#rating_definition'
  put 'backend/rating_definition', to:'backend#rating_definition'

  devise_for :users
end
