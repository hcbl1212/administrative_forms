class AddUniqueIndexToEmployeeEmail < ActiveRecord::Migration[5.1]
  def change
      add_index :employees, :employee_email, unique: true
  end
end
