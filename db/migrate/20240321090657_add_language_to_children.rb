class AddLanguageToChildren < ActiveRecord::Migration[7.1]
  def change
    add_column :children, :language, :string
  end
end
