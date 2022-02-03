class WorksController < ApplicationController
  def index
    @works = Work.all

    @albums = @works.select { |w| w.category == 'album' }
    @books = @works.select { |w| w.category == 'book' }
    @movies = @works.select { |w| w.category == 'movie' }
  end

  def top_ten
    @vote = Vote.find_by(work_id: @work.id)
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Successfully added: #{@work.title}!"
      redirect_to work_path(@work)
      return
    else
      flash.now[:error] = "Something happened. #{@work.title} not created"
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work.id)
      flash[:success] = "Successfully updated: #{@work.title}!"
      return
    else
      flash.now[:error] = "Something happened. #{@work.title} not updated"
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    else
      @work.destroy
      redirect_to works_path
      return
    end
  end

  private

  def work_params
    return(
      params
        .require(:work)
        .permit(
          :category,
          :title,
          :creator,
          :publication_year,
          :description,
          :session
        )
    )
  end
end
