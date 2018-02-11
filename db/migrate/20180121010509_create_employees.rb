class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.boolean :employee
      t.string :first_name
      t.string :last_name
      t.string :middle_initial
      t.string :job_title

      t.timestamps
    end
  end
end
