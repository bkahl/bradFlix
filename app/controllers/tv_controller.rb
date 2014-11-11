class TvController < ApplicationController

  def index
    @get_all_tv_shows = get_all_tv_shows.size
    @all_movie_years = get_all_movies_by_year.reverse_each
    @movies_alphabetically = get_all_movies.sort_by { |k, v| v[:name] }
    @movies_recent = get_all_movies.sort_by { |k, v| v[:date] }
    @movie_names = get_all_movie_titles(@movies_recent)
    @all_tv_shows = get_all_tv_shows
  end

  #def get_all_movies_by_year
  def get_all_tv_shows
    tv_path = '/Volumes/Mac.Movies/Ripped DVDs/TV Shows/'
    remove_path = '/Volumes/Mac.Movies'

    tv_dirs = Dir.glob(tv_path+'*')
    tv_shows = Hash.new{ |h,k| h[k]=Hash.new(&h.default_proc) }

    tv = Dir[tv_path+'**/*.m4v']

    tv.each do |show|
      puts show

      name = show.split(tv_path)[1].split('/')[0]
      season = show.split(tv_path)[1].split('/')[1]
      episode = show.split(tv_path)[1].split('/')[2].split(".m4v")[0]
      href = show.split(remove_path)[1]

      tv_shows[show] = {href: href, name: name, season: season, link: name+" - "+season+" - "+episode, episode: episode}

      # curr_tv_show = Dir.glob(dir+'/*')
      #
      # curr_tv_show.each do |show|
      #
      #   puts show
      #   name = show.split(tv_path)[1].split('/')[0]
      #   season = show.split(tv_path)[1].split('/')[1]
      #   path = show.split(remove_path)[1]
      #
      #   puts season
      #   #
      #   # curr_logo = Dir.glob(curr_movie_path+"/*.jpg")
      #   # curr_logo = curr_logo[0]
      #   #
      #   # date_modified = File.stat(curr_logo).mtime
      #   # curr_logo = curr_logo.split(remove_path)[1]
      #   #
      #   # curr_mp4 = Dir.glob(curr_movie_path+"/*.m4v")
      #   # curr_mp4 = curr_mp4[0]
      #   #
      #   # unless curr_mp4.nil?
      #   #   curr_mp4 = curr_mp4.split(remove_path)[1]
      #   # end
      #   #
      #   # movie_api_name = curr_movie.gsub(" ", "+")
      #   #
      #   # movies[curr_year][curr_movie] = {path: curr_movie_path.split(remove_path)[1], api_name: movie_api_name, api: "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey="+movie_api_name+"&qwwcbmq36xddhrcbpwwqmb5m&q=&page_limit=1", name: curr_movie, movie: curr_mp4, logo: curr_logo, year: curr_year, date: date_modified}
      #   #
      #   tv_shows[curr_tv_show] = {path: path+'/'+name, name: name, season: season}
      # end
    end

    return tv_shows
  end

end