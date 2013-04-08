class PerformancesController < ApplicationController
  def new
  end

  def create
  end

  def index
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def destroy
  end

  def edit
  end
end
