Rails.application.routes.draw do
  resources :projects
  post '/rate' => 'rater#create', :as => 'rate'
  resources :evaluations
  get 'evals_by_indicator', to:'evaluations#evals_by_indicator'
  resources :posts
  resources :projects
  resources :areas
  get 'area/children/:area_id', to:'areas#children', as: 'children'
  get 'area/new_child/:area_id', to:'areas#new_child', as: 'new_child'
  resources :area_levels
  get 'area_level/children/:area_level_id', to:'area_levels#children', as: 'area_level_children'
  get 'area_level/new_child/:area_level_id', to:'area_levels#new_child', as: 'new_area_level_child'
  devise_for :admins
  # get 'home/index'
  root to: "home#cover"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'index', to:'home#index'
  get 'about_us', to:'home#about_us'
  get 'citizen_obs', to:'home#citizen_obs'
  get 'get_informed', to:'home#get_informed'
  get 'initiatives', to:'home#initiatives'
  get 'registration', to:'home#registration'
  get 'contact', to:'home#contact'

  get 'backend/posts', to:'backend#posts'
  get 'backend/projects', to:'backend#projects'
  get 'backend/areas', to:'backend#areas'
  get 'backend/evaluations', to:'backend#evaluations'
  get 'backend/rating_definition', to:'backend#rating_definition'
  put 'backend/rating_definition', to:'backend#rating_definition'
  get 'backend/users', to:'backend#users'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", sessions: 'users/sessions', registrations: 'users/registrations' }
end
