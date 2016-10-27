class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    movieList = Movie.all
    @selected_ratings = params[:ratings] || {}
    if @selected_ratings == {}
      @selected_ratings = Hash[Movie.allRatings.map {|rating| [rating, rating]}]
    end
    
    movieList = Movie.where(rating: @selected_ratings.keys)
    
    if params[:title] == "sort"
      @movies = movieList.all.order(:title => "ASC")
      @title_header = "hilite"
      @release_date_header = nil
    elsif params[:release_date] == "sort"
      @movies = movieList.all.order(:release_date => "ASC")
      @release_date_header = "hilite"
      @title_header = nil
    else
      @movies = movieList
      @title_header = nil
      @release_date_header = nil
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
