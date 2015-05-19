class Guest < ActiveRecord::Base
  belongs_to :rsvp
  validates :name, presence: {message: "is required"}
  validates :meal, presence: true, inclusion: {in: %w(steak salmon vegetarian child), message: "was not selected"}

  scope :yes, -> { joins(:rsvp).where('rsvps.coming is true') }
  scope :no, -> { joins(:rsvp).where('rsvps.coming is false') }
end
