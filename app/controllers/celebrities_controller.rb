class CelebritiesController < ApplicationController

  def new
    @celebrity = Celebrity.new
  end

  def create
    @celebrity = Celebrity.new(params[:celebrity])
    @celebrity.save
  end

  def index
    @celebrities = Celebrity.all
  end

  def show
    @celebrity = Celebrity.find(params[:uid])
  end
end
