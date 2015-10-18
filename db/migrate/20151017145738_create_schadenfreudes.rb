class CreateSchadenfreudes < ActiveRecord::Migration
  def change
    create_table :schadenfreudes do |t|
      t.integer :my_current_condition_id
      t.integer :their_current_condition_id
      t.integer :user_id
      t.string :comment

      t.timestamps null: false
    end
  end
end
