class CheatingController < ApplicationController
  before_filter :restrict_to_admin

  def index
    @solutions = Solution.cheating
  end
end
