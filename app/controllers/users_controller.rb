class UsersController < ApplicationController
  def index
    # @users = User.order(date_joined :asc)
    @user = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name] #user input
    user = User.find_by(name: name)

    if user #if !user.nil?
      session[:user_id] = user.id #setting the session id to the user_id
      flash[:success] = "Successfully logged in as returning user #{name}"
    else
      user = User.create(name: name, date_joined: Date.today)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{user.name}"
    end
    redirect_to root_path
    return
  end

  def logout
    @current_user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    redirect_to root_path
  end
end

