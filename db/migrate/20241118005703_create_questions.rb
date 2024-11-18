class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.string :content
      t.string :image
      t.string :supplement
      t.integer :quiz_id
      t.integer :point_id

      t.timestamps
    end
  end
end
