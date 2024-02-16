class CreateChildren < ActiveRecord::Migration[7.1]
  def change
    create_table :children do |t|
      t.string :baby_name
      t.string :parent_name
      t.date :date_of_birth
      t.string :gender
      t.string :phone_number
      t.integer :weight

      t.timestamps
    end
  end
end
