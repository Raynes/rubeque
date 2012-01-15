class FollowingController < ApplicationController
  # GET /following
  # GET /following.json
  def index
    @following = Following.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @following }
    end
  end

  # GET /following/1
  # GET /following/1.json
  def show
    @following = Following.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @following }
    end
  end

  # GET /following/new
  # GET /following/new.json
  def new
    @following = Following.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @following }
    end
  end

  # GET /following/1/edit
  def edit
    @following = Following.find(params[:id])
  end

  # POST /following
  # POST /following.json
  def create
    @following = current_user.following.new(params[:following])

    respond_to do |format|
      if @following.save
        format.html { redirect_to @following, notice: 'Following was successfully created.' }
        format.json { render json: @following, status: :created, location: @following }
      else
        format.html { render action: "new" }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /following/1
  # PUT /following/1.json
  def update
    @following = Following.find(params[:id])

    respond_to do |format|
      if @following.update_attributes(params[:following])
        format.html { redirect_to @following, notice: 'Following was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /following/1
  # DELETE /following/1.json
  def destroy
    # note: params[:id] is the user_id not the following id
    @following = current_user.following.where(user_id: params[:id])
    @following.destroy

    respond_to do |format|
      format.html { redirect_to following_index_url }
      format.json { head :ok }
    end
  end
end
