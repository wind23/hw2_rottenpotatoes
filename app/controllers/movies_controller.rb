class MoviesController < ApplicationController

  

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    
  end

  def index
    @all_ratings = ['G','PG','PG-13','R']
    type = params[:sort_by]
    if params[:commit] == "Refresh"
        @movies = []
        @sort_by = 3
       	Movie.all.each do |e|
            if params[:ratings][e.rating]=='1'
               @movies.push(e)
            end
        end
        
    else
       # krue=(:order =>:release_date)
    #end
	    if type == "title"
		@movies = Movie.find(:all, :order => :title)
		@sort_by = 1
	    else
		if type == "release_date"
		    @movies = Movie.find(:all, :order => :release_date)
		    @sort_by = 2
		else
		    @movies = Movie.find(:all)
		    @sort_by = 3
		end
	    end
    end
  end

  def 

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
