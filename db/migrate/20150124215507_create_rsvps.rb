class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :coming
      t.integer :party_size
      t.text    :comment
      t.timestamps null: false
    end
  end
end
