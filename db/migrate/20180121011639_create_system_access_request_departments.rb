class CreateSystemAccessRequestDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :system_access_request_departments do |t|
      t.integer :system_access_request_id
      t.integer :department_id
      t.string  :other_text
      t.timestamps
    end
  end
end
