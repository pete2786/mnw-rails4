class CreatePhaseVotes < ActiveRecord::Migration
  def change
    create_table :phrase_votes do |t|
      t.belongs_to :phrase, index: true
      t.belongs_to :user, index: true
      t.integer :value, default: 1

      t.timestamps null: false
    end

    add_foreign_key :phrase_votes, :phrases
    add_foreign_key :phrase_votes, :users
  end
end
