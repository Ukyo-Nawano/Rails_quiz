class CreateQuizzes < ActiveRecord::Migration[7.2]
  def change
    create_table :quizzes do |t|
      t.string :content
      t.string :image
      t.string :supplement

      t.timestamps
    end
  end
end
