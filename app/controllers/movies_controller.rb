class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    
  end

  def index
    if @all_ratings == nil
      @all_ratings = ['G','PG','PG-13','R']
    end
    if @sort_by!=1 and @sort_by!=2
      @sort_by = 3
    end

    type = params[:sort_by] || session[:sort_by]
    @rat = params[:ratings] || session[:ratings]
    session[:ratings] = @rat
    session[:sort_by] = type

    if params[:ratings] == nil
        if params[:sort_by] == nil
            if session[:sort_by] != nil
                redirect_to(:action => "index", :sort_by => session[:sort_by])
            end
        end
    else
        if params[:sort_by] == nil
            if session[:sort_by] != nil
                redirect_to(:action => "index", :sort_by => session[:sort_by], :ratings => params[:ratings])
            end
        end
    end
  
    if @rat == nil
        @rat = {'G'=>'1','PG'=>'1','PG-13'=>'1','R'=>'1'}
    end

    if type == "title"
        @sort_by = 1
    elsif type == "release_date"
        @sort_by = 2
    end
        
    if @sort_by == 1
	@moviesx = Movie.find(:all, :order => :title)
    elsif @sort_by == 2
        @moviesx = Movie.find(:all, :order => :release_date)
    else
        @moviesx = Movie.find(:all)
    end
    @movies = []
    @moviesx.each do |movie|
       if @rat[movie.rating]=='1'
          @movies.push(movie)
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
