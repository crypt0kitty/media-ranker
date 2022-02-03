class VotesController < ApplicationController
  def create
    @user = User.find_by(id: session[:user_id])
    @work = Work.find(params[:work_id])
    @vote = Vote.new

    @vote.work_id = @work.id

    if @user.nil?
      flash[:error] = 'Please log in to upvote'
      redirect_to root_path
      return
    end

    @vote.user_id = @user.id
    @vote.date = Date.today.to_s(:long)

    if @vote.save
      flash[:session] = "Successfully upvoted: #{@work.title}!"
      redirect_to work_path(@work) #work_path(@work)
    else
      flash[:error] = 'Error, not able to upvote'
      redirect_to root_path
    end
  end
end
