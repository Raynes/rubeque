class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  def restrict_to_admin
    (current_user && current_user.admin?) || access_denied
  end
  
  def access_denied
    flash[:notice] = "Sorry, you can't #{params[:action]}."
    redirect_to action: :show
  end
end
