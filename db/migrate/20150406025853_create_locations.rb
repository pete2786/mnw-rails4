require 'csv'    

class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :place_id
      t.string :name
      t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :long, :precision => 15, :scale => 10
      t.string :country
      t.string :country2
      t.string :state
      t.string :time_zone

      t.timestamps null: false
    end
  end

  #csv_text = File.read('city.csv')
  #csv = CSV.parse(csv_text, :headers => true)
  #csv.each do |row|
  #  Location.create!(row.to_hash)
  #end
end
