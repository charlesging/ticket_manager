class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :assignee_name

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?  
    !!current_user
  end

  def assignee_name(ticket)
    return '' if ticket.assignee.empty?
    User.find(ticket.assignee.to_i).name
  end

  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to do that."
      redirect_to request.referrer
    end
  end

end
