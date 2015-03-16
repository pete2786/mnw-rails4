class CreateCurrentConditions < ActiveRecord::Migration
  def change
    create_table :current_conditions do |t|
      t.belongs_to :phrase, index: true
      t.string :location
      t.integer :temperature
      t.string :icon
      t.string :description
      t.string :code
      t.decimal :humidity
      t.decimal :lat
      t.decimal :long
      t.decimal :wind
      t.text :raw_response

      t.timestamps null: false
    end
    add_foreign_key :current_conditions, :phrases
  end
end
