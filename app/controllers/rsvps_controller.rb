class RsvpsController < ApplicationController
  DISABLED=true

  def list
    if ApplicationHelper.verify_admin_password(params[:password])
      render :list
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def index
    if DISABLED
      render template: 'shared/coming_soon'
    else
      @rsvp = Rsvp.new
      render action: :new
    end
  end

  def new
    
  end

  # "rsvp" => {
  #   "first_name"=>"Jeff",
  #   "last_name"=>"Gran",
  #   "email"=>"jeff.gran@gmail.com",
  #   "coming"=>"true",
  #   "party_size"=>"1",
  #   "guests"=>[
  #     {"name"=>"Jeff", "meal"=>"steak"}
  #   ]
  # }
  def create
    @rsvp = Rsvp.find_by_email(rsvp_params[:email]) || Rsvp.new
    @rsvp.attributes = rsvp_params
    rsvp_valid = @rsvp.valid?
    robot_test = verify_recaptcha(:model => @rsvp, :message => "Are you sure you're a robot?")
    if robot_test && rsvp_valid && @rsvp.save
      redirect_to(thank_you_rsvp_path(@rsvp))
    else
      render :new
    end
  end
  alias update create

  def thank_you
    @rsvp = Rsvp.find(params.require(:id))
  end

  private

  def rsvp_params
    params.require(:rsvp).permit([:first_name, :last_name, :email, :party_size, :coming, {guests_attributes: [:name, :meal]}])
  end

  def recaptcha_params
    params.require('g-recaptcha-response')
  end
end
