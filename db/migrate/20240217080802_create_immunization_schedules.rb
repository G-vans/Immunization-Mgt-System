class CreateImmunizationSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :immunization_schedules do |t|
      t.string :vaxx_name
      t.date :scheduled_date
      t.references :child, null: false, foreign_key: true
      t.references :medic, null: false, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
