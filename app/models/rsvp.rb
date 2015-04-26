class Rsvp < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :email
  validates_inclusion_of :coming, :in => [true, false]
  validates_presence_of :party_size, if: :coming?
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  has_many :guests, validate: false, dependent: :destroy
  accepts_nested_attributes_for :guests

  validate :number_of_guests_matches_party_size
  def number_of_guests_matches_party_size
    errors.add(:guests, "missing") unless guests.size == party_size.to_i
  end

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
  
end
