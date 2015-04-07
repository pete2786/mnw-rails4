class AddIndexes < ActiveRecord::Migration
  def change
    add_index(:locations, :place_id)
  end
end
