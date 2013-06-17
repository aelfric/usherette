class PerformancesController < ApplicationController
    before_filter :authenticate_user!, :only => [:create, :edit, :destroy, :update]
  def new
      @show = Show.find(params[:show_id])
      @performance = Performance.new()
      @venues = Venue.all
  end

  def create
      @performance = Performance.new(params[:performance])
      @performance.save
  end

  def index
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
      @performances_by_date = Performance.all.group_by { |p| p.date.to_date }
      @performance = Performance.first
  end

  def show
      @performance = Performance.find(params[:id])
  end

  def destroy
  end

  def edit
  end
end
