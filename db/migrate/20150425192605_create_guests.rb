class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.integer :rsvp_id
      t.string :name
      t.string :meal
    end
  end
end
