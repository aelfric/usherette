class PerformancesController < ApplicationController
    before_filter :authenticate_user!, :only => [:create, :edit, :destroy, :update]
  def new
      @show = Show.find(params[:show_id])
      @performance = Performance.new()
      @venues = Venue.all
  end

  def create
      @performance = Performance.new(params[:performance])
      @show = Show.find(params[:performance][:show_id])
    respond_to do |format|
      if @performance.save
        format.html { redirect_to @performance, notice: 'Performance was successfully created.' }
        format.json { render json: @performance, status: :created, location: @performance }
      else
        format.html { render action: "new" }
        format.json { render json: @performance.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
      @date = params[:date] ? Date.parse(params[:date]) : [Performance.minimum(:date).to_date,Date.today.to_date].max
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
