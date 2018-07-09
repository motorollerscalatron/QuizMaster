class CreateChallenges < ActiveRecord::Migration[5.1]
  def change
    create_table :challenges do |t|
      t.integer :question_id
      t.integer :user_id
      t.boolean :result

      t.timestamps
    end
    add_index :challenges, :question_id
    add_index :challenges, :user_id
  end
end
