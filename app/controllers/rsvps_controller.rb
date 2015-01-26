class RsvpsController < ApplicationController

  def index
    redirect_to action: :coming_soon
  end

  def create
    redirect_to action: :thank_you
  end

  # def thank_you
  # end
  # def coming_soon
  # end

end
