class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_admin?
  around_filter Mongoid::History::Sweeper.instance

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

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || problems_path
  end

end
