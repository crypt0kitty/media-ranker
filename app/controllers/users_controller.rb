class UsersController < ApplicationController
  def index
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

    if user
      #if !user.nil?
      session[:user_id] = user.id #setting the session id to the user_id
      flash[:success] = "Returning user: #{name.upcase}"
    else
      user = User.create(name: name, date_joined: Date.today.to_s(:long))
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name.upcase}!"
    end
    redirect_to root_path
    return
  end

  def logout
    @current_user = User.find_by(id: session[:user_id])
    flash[:success] = "Bye, #{@current_user.name.upcase}!"
    session[:user_id] = nil
    redirect_to root_path
  end
end
