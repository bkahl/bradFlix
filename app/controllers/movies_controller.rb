class MoviesController < ApplicationController

  before_filter :get_all_movies_by_year
  before_filter :get_all_movies

  def index
    @all_movie_years = get_all_movies_by_year
    @movies_by_year = get_all_movies_by_year
    @movies_recent = get_all_movies.sort_by { |k, v| v[:date] }
  end

  def year
    @all_movie_years = get_all_movies_by_year
    @movies_by_selected_year = get_all_movies_by_year[params[:year]]
  end

  def recent
    @all_movie_years = get_all_movies_by_year
    @movies_recent = get_all_movies.sort_by { |k, v| v[:date] }
  end

  def selected
  end

  private

end