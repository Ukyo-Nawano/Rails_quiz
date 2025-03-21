class AddDescriptionToQuizzes < ActiveRecord::Migration[7.2]
  def change
    add_column :quizzes, :description, :text
  end
end
