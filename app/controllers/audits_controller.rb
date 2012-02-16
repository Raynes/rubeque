class AuditsController < ApplicationController
  before_filter :restrict_to_admin

  def index
    @audits = HistoryTracker.all
  end
end
