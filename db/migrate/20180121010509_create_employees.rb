class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.boolean :employee
      t.text :first_name
      t.text :last_name
      t.text :middle_initial
      t.text :job_title

      t.timestamps
    end
  end
end
