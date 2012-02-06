class SolutionsController < ApplicationController
  # GET /solutions
  # GET /solutions.json
  before_filter :restrict_to_admin, only: [:edit, :destroy, :show, :new]

  def index
    @problem = Problem.find(params[:problem_id]) rescue nil
    if !current_user_admin? && (@problem.nil? || !@problem.solved?(current_user))
      redirect_to "/" and return
    end
    @top_solutions = Solution.all(conditions: { problem_id: @problem.id }, sort: [[:score, :desc]], limit: 5)
    @followed_users = current_user.users_followed.reject{|u| u.solutions.where(problem_id: @problem.id).empty?}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @solutions }
    end
  end

  # GET /solutions/1
  # GET /solutions/1.json
  def show
    @solution = Solution.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @solution }
    end
  end

  # GET /solutions/1/edit
  def edit
    @solution = Solution.find(params[:id])
  end

  # POST /solutions
  # POST /solutions.json
  def create
    @solution = Solution.new(params[:solution])
    @solution.user = current_user
    @problem = @solution.problem

    respond_to do |format|
      if run_and_save_solution(@solution)
        notice = 'Your solution passed!'
        notice += '  Please sign in or register to earn points.' if current_user.blank?
        format.html { redirect_to problem_path(@problem.id, solution_code: @solution.code), notice: notice }
        format.json { render json: @solution, status: :created, location: @solution }
      else
        flash.now[:error] = "Sorry, that solution didn't work! Try again."
        format.html { render "/problems/show" }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /solutions/1
  # PUT /solutions/1.json
  def update
    @solution = Solution.find(params[:id])
    if @solution.user != current_user && !current_user.admin?
      flash[:error] = "You cannot update that solution"
      redirect_to "/" and return
    end
    @problem = @solution.problem

    respond_to do |format|
      if @solution.update_attributes(params[:solution])
        format.html { redirect_to @problem, notice: 'Solution was successfully updated.' }
        format.json { head :ok }
      else
        flash.now[:error] = "Sorry, that solution didn't work! Try again."
        format.html { render "/problems/show" }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solutions/1
  # DELETE /solutions/1.json
  def destroy
    @solution = Solution.find(params[:id])
    @solution.destroy

    respond_to do |format|
      format.html { redirect_to solutions_url }
      format.json { head :ok }
    end
  end

  private

    def run_and_save_solution(solution)
      if current_user
        return solution.save
      else
        # don't save solutions unless we have a logged in user
        return solution.valid?
      end
    end
end
