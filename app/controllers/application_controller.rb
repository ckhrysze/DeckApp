# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def require_login
    if session[:current_user_name].nil?
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_url # halts request cycle
    end 
  end
end
