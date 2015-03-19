class AddUserToModels < ActiveRecord::Migration
  def change
    add_column :stock_images, :user_id, :integer
    add_column :current_conditions, :user_id, :integer
  end
end
