class CelerbrityController < ApplicationController

  def new
    @celebrity = Celebrity.new
  end

  def create
    @celebrity = Celebrity.new(params[:celebrity])
    @celebrity.save
  end
end
