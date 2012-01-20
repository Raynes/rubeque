class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_admin?
  
  protected
  def restrict_to_admin
    case
    when !current_user then require_login
    when current_user.admin? then true
    else access_denied
    end
  end
  
  def require_login
    flash[:alert] = "You need to log in to access this page."
    redirect_to new_user_session_path
  end
    
  def access_denied
    flash[:alert] = "Sorry, you can't access the page you requested."
    redirect_to "/"
  end
  
  def current_user_admin?
    current_user && current_user.admin?
  end
end
