class CreateTagQuizzes < ActiveRecord::Migration[7.2]
  def change
    create_table :tag_quizzes do |t|
      t.integer :quiz_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
