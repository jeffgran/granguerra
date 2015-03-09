class RsvpsController < ApplicationController

  def index
    @rsvp = Rsvp.new
    render action: :new
  end

  def new
    
  end

  def create
    @rsvp = Rsvp.new(rsvp_params)
    rsvp_valid = @rsvp.valid?
    robot_test = verify_recaptcha(:model => @rsvp, :message => "Are you sure you're a robot?")
    if robot_test && rsvp_valid && @rsvp.save
      redirect_to(thank_you_rsvp_path(@rsvp))
    else
      render :new
    end
  end

  def thank_you
    @rsvp = Rsvp.find(params.require(:id))
  end

  private

  def rsvp_params
    params.require(:rsvp).permit([:first_name, :last_name, :email, :party_size, :coming])
  end

  def recaptcha_params
    params.require('g-recaptcha-response')
  end
end
