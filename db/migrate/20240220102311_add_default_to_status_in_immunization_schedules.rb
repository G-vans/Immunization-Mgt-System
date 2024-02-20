class AddDefaultToStatusInImmunizationSchedules < ActiveRecord::Migration[7.1]
  def change
    change_column :immunization_schedules, :status, :boolean, default: false
  end
end
