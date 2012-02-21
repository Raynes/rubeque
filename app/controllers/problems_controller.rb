class ProblemsController < ApplicationController
  # GET /problems
  # GET /problems.json
  
  before_filter :restrict_to_admin, only: [:edit,:update,:destroy,:unapproved]
  before_filter :authenticate_user!, only: [:new]
  
  def index
    @problems = Problem.approved.asc(:difficulty).asc(:order_number).page(params[:page] || 1)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @problems }
    end
  end

  def unapproved
    @problems = Problem.unapproved.asc(:created_at).page(params[:page] || 1)
    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @problems }
    end
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    @problem = Problem.find(params[:id])
    if !@problem.approved? && !current_user_admin?
      redirect_to "/" and return
    end

    @solution = if current_user && (solution =  @problem.solutions.where(user_id: current_user.id).first)
      solution
    else
      Solution.new(problem: @problem, code: params[:solution_code])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @problem }
    end
  end

  # GET /problems/new
  # GET /problems/new.json
  def new
    @problem = Problem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @problem }
    end
  end

  # GET /problems/1/edit
  def edit
    @problem = Problem.find(params[:id])
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(params[:problem])
    @problem.creator = current_user

    respond_to do |format|
      if @problem.save
        format.html { redirect_to problems_path, notice: 'Problem was successfully submitted.' }
        format.json { render json: @problem, status: :created, location: @problem }
      else
        format.html { render action: "new" }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def approve
    @problem = Problem.find(params[:id])
    @problem.approved = true
    respond_to do |format|
      if @problem.save
        format.html { redirect_to({action: 'unapproved'}, {notice: 'Problem was successfully approved.'}) }
        format.json { head :ok }
      else
        format.html { redirect_to @problem, notice: 'Approval failed!' }
      end
    end
  end

  # PUT /problems/1
  # PUT /problems/1.json
  def update
    @problem = Problem.find(params[:id])

    respond_to do |format|
      if @problem.update_attributes(params[:problem])
        format.html { redirect_to @problem, notice: 'Problem was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem = Problem.find(params[:id])
    @problem.destroy

    respond_to do |format|
      format.html { redirect_to problems_url }
      format.json { head :ok }
    end
  end
end
