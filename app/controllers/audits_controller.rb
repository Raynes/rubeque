class AuditsController < ApplicationController
  before_filter :restrict_to_admin

  def index
    @audits = HistoryTracker.desc("created_at").page(params[:page] || 1)
  end

  def show
    @audit = HistoryTracker.find(params[:id])
  end
end
