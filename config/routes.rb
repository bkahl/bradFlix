BradFlix::Application.routes.draw do

  #devise_for :users

  root :to => 'movies#recent', :nav => 'Recently Added'

  #match movie
  match '/movies', :to => 'movies#index', :nav => 'Alphabetically'
  match '/movies/recent', :to => 'movies#recent', :nav => 'Recently Added'
  match '/movies/recently_watched', :to => 'movies#recently_watched', :nav => 'Recently Watched'
  match '/movies/:year', :to => 'movies#year', :as => 'movie_year', :nav => 'year'
  match '/movies/:year/:movie_name', :to => 'movies#description', :as => 'movie_name', :nav => 'description'

  #match tv shows
  match '/tv', :to => 'tv#index', :nav => 'TV'

  #restart bradflix on local iTunes
  match '/restart', :to => 'restart#index'

end
