class SolutionsController < ApplicationController
  # GET /solutions
  # GET /solutions.json
  before_filter :restrict_to_admin, only: [:edit, :destroy, :show, :new]
  respond_to :html, :json

  def index
    @problem = Problem.find(params[:problem_id]) rescue (redirect_to "/" and return)
    if !current_user_admin? && (@problem.nil? || !@problem.solved?(current_user))
      redirect_to @problem and return
    end
    @top_solutions = Solution.where(problem_id: @problem.id, user_id: { "$nin" => [current_user.id] }).
      desc(:score).desc(:updated_at).page(params[:page] || 1)
    @followed_solutions = current_user.users_followed.map {|u| u.solutions.where(problem_id: @problem.id).first}.compact

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
      format.html { redirect_to @solution.problem }
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
        notice += ' Please sign in or register to earn points.' if current_user.blank?
        notice += " #{share_link}" 
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
      if update_solution(@solution)
        message = current_user_admin? && params[:bypass_run_code] ? "Solution successfully updated." : "Solution passed and was updated. #{share_link}"
        format.html { redirect_to @problem, notice: message }
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
    problem = @solution.problem
    @solution.destroy

    flash[:notice] = "Successfully destroyed solution."
    respond_to do |format|
      format.html { redirect_to problem }
      format.json { head :ok }
    end
  end

  def share
    @problem = Problem.find(params[:problem_id])
    if (@solution_code = @problem.code.gsub("__", params[:solution_code])).blank?
      redirect_to @problem and return
    end
    text = render_to_string "shared/code_refheap.text"
    @paste = CodeRefheap.create(text)

    respond_to do |format|
      format.html
      format.json { head :ok }
    end
  end

  def report
    @solution = Solution.find(params[:id])
    notify = !@solution.cheating? # don't notify admins if it's already marked as cheating
    @solution.update_attribute(:cheating, true)
    SolutionMailer.cheating_notification(@solution, current_user).deliver if notify

    respond_to do |format|
      format.html { redirect_to problem_solutions_path(@solution.problem), notice: "Thank you for reporting a solution." }
      format.json { respond_with @solution }
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

    def share_link
      "<a href='#{share_problem_solutions_path(@problem, solution_code: @solution.code)}'>Share your solution</a>!"
    end

    def update_solution(solution)
      if current_user_admin? && params[:bypass_run_code]
        solution.assign_attributes(params[:solution], as: :admin)
        solution.save(validate: false)
      else
        solution.update_attributes(params[:solution])
      end
    end

end
