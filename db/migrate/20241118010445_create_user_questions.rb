class CreateUserQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :user_questions do |t|
      t.integer :user_id
      t.integer :question_id
      t.boolean :result
      t.boolean :is_first

      t.timestamps
    end
  end
end
