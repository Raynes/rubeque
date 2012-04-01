class UsersController < ApplicationController
  before_filter :restrict_to_admin, only: [:edit,:update,:destroy]
  
  def index
    @users = User.asc(:rank).page(params[:page] || 1)
  end
  
  def show
    @user = User.find(params[:id])
  end
end