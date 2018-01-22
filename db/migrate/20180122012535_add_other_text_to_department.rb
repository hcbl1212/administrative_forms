class AddOtherTextToDepartment < ActiveRecord::Migration[5.1]
  def change
    add_column :departments, :other_text, :string
  end
end
