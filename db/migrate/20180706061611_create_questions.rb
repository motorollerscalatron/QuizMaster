class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :description
      t.text :answer
      t.boolean :is_public, default: false, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :questions, [:user_id, :created_at, :is_public]
  end
end
