class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.integer :person_id
      t.boolean :coming
      t.integer :party_size
      t.text    :comment
      t.timestamps null: false
    end
  end
end
