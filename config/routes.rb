BradFlix::Application.routes.draw do

  devise_for :users

  root :to => 'recent#index'

  #match recent
  match '/recent', :to => 'recent#index'

  #match movie
  match '/movies', :to => 'movies#index'
  match '/movies/:year', :to => 'movies#year', :as => 'movie_year'
  match '/movies/:year/:movie_name', :to => 'movies#description'

end
