class StaticController < ApplicationController
  before_filter :restrict_to_admin, only: [:admin]

  def index
  end
  
  def help
    
  end

  def admin
  end

end
