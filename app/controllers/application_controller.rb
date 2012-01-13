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
    flash[:notice] = "You need to signin to access this resource."
    redirect_to new_user_session_path
  end
    
  def access_denied
    flash[:notice] = "Sorry, you can't #{params[:action]}."
    redirect_to action: :show
  end
  
  def current_user_admin?
    current_user && current_user.admin?
  end
end
