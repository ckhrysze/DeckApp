# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def require_login
    if session[:user].nil?
      @user = User.find_by_nick("default")
      session[:user] = @user.id
      #flash[:error] = "You must be logged in to access this section"
      #redirect_to root_url # halts request cycle
    else
      @user = User.find(session[:user])
    end
  end
end
