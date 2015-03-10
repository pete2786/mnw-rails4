class CreateStockImages < ActiveRecord::Migration
  def change
    create_table :stock_images do |t|
      t.string :image
      t.string :season
      t.string :location

      t.timestamps null: false
    end
  end
end
