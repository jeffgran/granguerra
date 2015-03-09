class Rsvp < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :email
  validates_inclusion_of :coming, :in => [true, false]
  validates_presence_of :party_size, if: :coming?
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
