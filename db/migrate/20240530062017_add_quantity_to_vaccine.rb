class AddQuantityToVaccine < ActiveRecord::Migration[7.1]
  def change
    add_column :vaccines, :quantity, :integer
  end
end
