class CreateSavedLocations < ActiveRecord::Migration
  def change
    create_table :saved_locations do |t|
      t.string :name
      t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :long, :precision => 15, :scale => 10
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
