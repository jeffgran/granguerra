class RsvpsController < ApplicationController

  def index
    
  end

  def create
    redirect_to action: :thank_you
  end

  def thank_you
  end

end
