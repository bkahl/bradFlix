BradFlix::Application.routes.draw do

  devise_for :users

  root :to => 'movies#recent'

  #match movie
  match '/movies', :to => 'movies#index'
  match '/movies/recent', :to => 'movies#recent'
  match '/movies/:year', :to => 'movies#year', :as => 'movie_year'
  match '/movies/:year/:movie_name', :to => 'movies#description'

end
