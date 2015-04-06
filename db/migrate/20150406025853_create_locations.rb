require 'csv'    

class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :place_id
      t.string :name
      t.decimal :lat
      t.decimal :long
      t.string :country
      t.string :country2
      t.string :state
      t.string :time_zone

      t.timestamps null: false
    end
  end
end
