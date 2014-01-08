class MoviesController < ApplicationController

  def index
    @count_all_movies = get_all_movies.size
    @all_movie_years = get_all_movies_by_year.reverse_each
    #@movies_by_year = get_all_movies_by_year // use for _movies partial
    @movies_alphabetically = get_all_movies.sort_by { |k, v| v[:name] }
    @movies_recent = get_all_movies.sort_by { |k, v| v[:date] }
    @movie_names = get_all_movie_titles(@movies_recent)
  end

  def year
    @count_all_movies = get_all_movies_by_year[params[:year]].size
    @all_movie_years = get_all_movies_by_year.reverse_each
    @movies_by_selected_year = get_all_movies_by_year[params[:year]].sort_by { |k, v| v[:name] }
    @movies_recent = get_all_movies.sort_by { |k, v| v[:date] }
    @movie_names = get_all_movie_titles(@movies_recent)
  end


  def recent
    @count_all_movies = get_all_movies.size
    @all_movie_years = get_all_movies_by_year.reverse_each
    @movies_recent = get_all_movies.sort_by { |k, v| v[:date] }
    @movie_names = get_all_movie_titles(@movies_recent)
  end

  def description
    @all_movie_years = get_all_movies_by_year.reverse_each
    @movie_description = get_selected_movie(params[:year], params[:movie_name])
    @movies_recent = get_all_movies.sort_by { |k, v| v[:date] }
    @movie_names = get_all_movie_titles(@movies_recent)
  end

  private

  def get_all_movie_titles(movies)
    movie_names = Array.new

    movies.each do |movie|
      movie_names.push(movie[1])
    end

    return movie_names.to_json
  end

end