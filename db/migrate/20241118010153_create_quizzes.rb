class CreateQuizzes < ActiveRecord::Migration[7.2]
  def change
    create_table :quizzes do |t|
      t.string :title
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
