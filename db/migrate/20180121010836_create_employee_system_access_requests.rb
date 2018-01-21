class CreateEmployeeSystemAccessRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_system_access_requests do |t|
      t.integer :employee_id
      t.integer :system_access_id

      t.timestamps
    end
  end
end
