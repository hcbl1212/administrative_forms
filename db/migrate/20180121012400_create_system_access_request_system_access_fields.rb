class CreateSystemAccessRequestSystemAccessFields < ActiveRecord::Migration[5.1]
  def change
    create_table :system_access_request_system_access_fields do |t|
      t.integer :system_access_request_id
      t.integer :system_access_field_id

      t.timestamps
    end
  end
end
