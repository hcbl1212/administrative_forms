class CreateSystemAccessRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :system_access_requests do |t|
      t.date    :effective_date
      t.integer :employee_id
      t.text :reason
      t.text :privileged_access
      t.text :business_justification
      t.text :special_instructions
      t.text :other_access
      t.text :sales_rep_email

      t.timestamps
    end
  end
end
