class CreateEducationalMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :educational_messages do |t|
      t.string :title
      t.text :content
      t.string :category
      t.string :duration
      t.references :medic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
