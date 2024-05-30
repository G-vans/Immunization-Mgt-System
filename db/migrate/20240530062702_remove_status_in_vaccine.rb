class RemoveStatusInVaccine < ActiveRecord::Migration[7.1]
  def change
    remove_column :vaccines, :status
  end
end
