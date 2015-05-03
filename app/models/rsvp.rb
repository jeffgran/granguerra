class Rsvp < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :email
  validates_inclusion_of :coming, :in => [true, false]
  validates_presence_of :party_size, if: :coming?
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  has_many :guests, validate: false, dependent: :destroy
  accepts_nested_attributes_for :guests

  validate :guests_are_valid
  def guests_are_valid
    guests.each.with_index do |guest, i|
      unless guest.valid?
        guest.errors.each do |field, message|
          errors.add(:base, "Guest #{i+1}'s #{field} #{message}")
        end
        errors[:guests].clear
        guest.errors.clear
      end
    end
  end

  before_validation :destroy_guests, on: :update
  def destroy_guests
    guests.each do |g|
      g.destroy unless g.new_record?
    end
  end

  before_validation :reset_party_size, on: :update
  def reset_party_size
    if coming == false
      self.party_size = 0
    end
  end
  
end
