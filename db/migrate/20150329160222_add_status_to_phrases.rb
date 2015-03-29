class AddStatusToPhrases < ActiveRecord::Migration
  def change
    add_column :phrases, :status, :string, default: 'phrase'
  end
end
