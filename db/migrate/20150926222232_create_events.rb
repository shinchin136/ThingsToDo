class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :venue
      t.string :start_time
      t.string :end_time
      t.boolean :all_day
      t.string :address

      t.integer :itinerary_id

      t.timestamps null: false
    end
  end
end
