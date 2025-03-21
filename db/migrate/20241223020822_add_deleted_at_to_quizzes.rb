class AddDeletedAtToQuizzes < ActiveRecord::Migration[7.2]
  def change
    add_column :quizzes, :deleted_at, :datetime
  end
end
