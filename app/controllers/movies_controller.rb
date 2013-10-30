class MoviesController < ApplicationController
  before_filter :get_movies

  def index
    @movies = get_movies
    @movies_recent = get_all_movies
  end

  def year
    @movies = get_movies[params[:year]]
  end

  def selected
  end

  private
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

        movies[curr_year][curr_movie] = {path: curr_movie_path.split(remove_path)[1], name: curr_movie, movie: curr_mp4, logo: curr_logo, date: date_modified}
      end
    end

    return movies
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

        movies[curr_movie] = {path: curr_movie_path.split(remove_path)[1], name: curr_movie, movie: curr_mp4, logo: curr_logo, year: curr_year, date: date_modified.to_s}
      end
    end

    return movies
  end
end