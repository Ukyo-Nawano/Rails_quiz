class CreateChoices < ActiveRecord::Migration[7.2]
  def change
    create_table :choices do |t|
      t.integer :question_id
      t.string :name
      t.boolean :is_valid

      t.timestamps
    end
  end
end
