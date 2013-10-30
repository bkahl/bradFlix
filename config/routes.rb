BradFlix::Application.routes.draw do

  root :to => 'home#index'

  #match movie
  match '/movies', :to => 'movies#index'
  match '/movies/:year', :to => 'movies#year', :as => 'movie_year'
  match '/movies/:year/:movie_name', :to => 'movies#description'

end
