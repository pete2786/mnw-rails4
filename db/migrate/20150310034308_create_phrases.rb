class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.string :season
      t.string :location
      t.text :phrase
      t.text :condition
      t.text :temperature
      t.text :windy
      t.text :humid
      t.integer :stock_image_id
      t.string :custom_image

      t.timestamps null: false
    end
  end
end
