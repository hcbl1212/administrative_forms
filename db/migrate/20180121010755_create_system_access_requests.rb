class CreateSystemAccessRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :system_access_requests do |t|
      t.date    :effective_date
      t.integer :employee_id
      t.string :reason
      t.string :privileged_access
      t.string :business_justification
      t.string :special_instructions
      t.string :other_access
      t.string :sales_rep_email

      t.timestamps
    end
  end
end
