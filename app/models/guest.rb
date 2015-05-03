class Guest < ActiveRecord::Base
  belongs_to :rsvp
  validates :name, presence: {message: "is required"}
  validates :meal, presence: true, inclusion: {in: %w(steak salmon vegetarian child), message: "was not selected"}
end
