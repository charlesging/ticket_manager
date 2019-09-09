
class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.where(email: params[:email]).first

    if user && user.authenticate(params[:password])
      # create a session where user id is stored in session hash
      session[:user_id] = user.id
      flash[:notice] = "Welcome, You've been logged in."
      redirect_to root_path
    else
      flash[:error] = "Something went wrong. Please try again."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You could not be logged in."
    redirect_to root_path
  end
end