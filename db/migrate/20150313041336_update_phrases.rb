class UpdatePhrases < ActiveRecord::Migration
  def change
    remove_column :phrases, :humid
    remove_column :phrases, :windy
    add_column :phrases, :user_id, :integer
    add_column :phrases, :immortal, :boolean, default: false
  end
end
