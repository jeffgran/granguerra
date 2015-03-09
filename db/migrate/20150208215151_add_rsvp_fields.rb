class AddRsvpFields < ActiveRecord::Migration
  def change
    add_column :rsvps, :first_name, :string
    add_column :rsvps, :last_name, :string
    add_column :rsvps, :email, :string
    add_column :rsvps, :coming, :boolean
    add_column :rsvps, :party_size, :integer
    add_column :rsvps, :comment, :text
  end
end
