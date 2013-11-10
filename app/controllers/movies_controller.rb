class MoviesController < ApplicationController

  def index
    @all_movie_years = get_all_movies_by_year.reverse_each
    #@movies_by_year = get_all_movies_by_year // use for _movies partial
    @movies_alphabetically = get_all_movies.sort_by { |k, v| v[:name] }
  end

  def year
    @all_movie_years = get_all_movies_by_year.reverse_each
    @movies_by_selected_year = get_all_movies_by_year[params[:year]].sort_by { |k, v| v[:date] }.reverse_each
  end

  def recent
    @all_movie_years = get_all_movies_by_year.reverse_each
    @movies_recent = get_all_movies.sort_by { |k, v| v[:date] }
  end

  def description
    @all_movie_years = get_all_movies_by_year.reverse_each
    @movie_description = get_selected_movie(params[:year], params[:movie_name])
  end

  private

end