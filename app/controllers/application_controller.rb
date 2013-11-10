class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  before_filter :get_all_movies_by_year
  before_filter :get_all_movies
  #before_filter :get_selected_movie

  protect_from_forgery

  def index

  end

  def get_all_movies_by_year
    movie_path = '/Volumes/Mac.Movies/Ripped DVDs/Movies/'
    remove_path = '/Volumes/Mac.Movies'

    movie_dirs = Dir.glob(movie_path+'*')
    movies = Hash.new{ |h,k| h[k]=Hash.new(&h.default_proc) }

    movie_dirs.each do |dir|
      curr_year = dir.split(movie_path)[1]
      curr_year_movies = Dir.glob(dir+'/*')

      curr_year_movies.each do |curr_movie_path|

        curr_movie = curr_movie_path.split(movie_path+curr_year+'/')[1]

        curr_logo = Dir.glob(curr_movie_path+"/*.jpg")
        curr_logo = curr_logo[0]

        date_modified = File.stat(curr_logo).mtime
        curr_logo = curr_logo.split(remove_path)[1]

        curr_mp4 = Dir.glob(curr_movie_path+"/*.m4v")
        curr_mp4 = curr_mp4[0]

        unless curr_mp4.nil?
          curr_mp4 = curr_mp4.split(remove_path)[1]
        end

        movie_api_name = curr_movie.gsub(" ", "+")

        movies[curr_year][curr_movie] = {path: curr_movie_path.split(remove_path)[1], api_name: movie_api_name, api: "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey="+movie_api_name+"&qwwcbmq36xddhrcbpwwqmb5m&q=&page_limit=1", name: curr_movie, movie: curr_mp4, logo: curr_logo, year: curr_year, date: date_modified}

      end
    end

    return movies
  end

  def get_selected_movie(year, movie)

      path = '/Volumes/Mac.Movies/Ripped DVDs/Movies/'
      remove_path = '/Volumes/Mac.Movies'

      rt_api = rt_api_getMovie(movie)
      puts rt_api

      movie = movie.gsub("+", " ")
      movie_path = path+year+'/'+movie
      puts movie_path

      curr_logo = Dir.glob(movie_path+"/*.jpg")
      curr_logo = curr_logo[0]
      curr_logo = '/'+curr_logo.split(remove_path+'/')[1]
      puts curr_logo

      curr_mp4 = Dir.glob(movie_path+"/*.m4v")
      curr_mp4 = curr_mp4[0]
      curr_mp4 = '/'+curr_mp4.split(remove_path+'/')[1]
      puts curr_mp4

      movie_hash = {movie: curr_mp4, logo: curr_logo, rotten_api: rt_api}
      puts movie_hash

      return movie_hash
  end

  def get_all_movies
    movie_path = '/Volumes/Mac.Movies/Ripped DVDs/Movies/'
    remove_path = '/Volumes/Mac.Movies'

    movie_dirs = Dir.glob(movie_path+'*')
    movies = Hash.new{ |h,k| h[k]=Hash.new(&h.default_proc) }

    movie_dirs.each do |dir|
      curr_year = dir.split(movie_path)[1]
      curr_year_movies = Dir.glob(dir+'/*')

      curr_year_movies.each do |curr_movie_path|

        curr_movie = curr_movie_path.split(movie_path+curr_year+'/')[1]

        curr_logo = Dir.glob(curr_movie_path+"/*.jpg")
        curr_logo = curr_logo[0]

        date_modified = File.stat(curr_logo).mtime
        curr_logo = curr_logo.split(remove_path)[1]

        curr_mp4 = Dir.glob(curr_movie_path+"/*.m4v")
        curr_mp4 = curr_mp4[0]

        unless curr_mp4.nil?
          curr_mp4 = curr_mp4.split(remove_path)[1]
        end

        movie_api_name = curr_movie.gsub(" ", "+")

        movies[curr_movie] = {path: curr_movie_path.split(remove_path)[1], api_name: movie_api_name, api: "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey="+movie_api_name+"&qwwcbmq36xddhrcbpwwqmb5m&q=&page_limit=1", name: curr_movie, movie: curr_mp4, logo: curr_logo, year: curr_year, date: date_modified.to_s}

      end
    end

    return movies
  end

  #need to make faster calls
  def rt_api_getMovie(movie_lookup)

    movie_name = movie_lookup
    #puts movie_name

    rotten_tomatoes_api_key = "qwwcbmq36xddhrcbpwwqmb5m"+"&q="+movie_name+"&page_limit=1"
    #puts rotten_tomatoes_api_key

    movie_call = HTTParty.get "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey="+rotten_tomatoes_api_key
    #puts movie_call

    json = JSON.parse(movie_call)
    #puts json

    #puts json["movies"][0]

    return json["movies"][0]

    #puts json["movies"][0]
    #puts json["movies"][0]["ratings"]["critics_score"]
    #puts json["movies"][0]["ratings"]["audience_score"]
    #puts json["movies"][0]["synopsis"]
    #puts json["movies"][0]["runtime"]
    #puts json["movies"][0]["mpaa_rating"]

  end

end
