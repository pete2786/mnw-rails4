class AddPopulationToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :population, :integer
  end
end
