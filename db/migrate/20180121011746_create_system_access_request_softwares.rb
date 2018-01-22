class CreateSystemAccessRequestSoftwares < ActiveRecord::Migration[5.1]
  def change
    create_table :system_access_request_softwares do |t|
      t.integer :system_access_request_id
      t.integer :software_id
      t.integer :role_id
      t.timestamps
    end
  end
end
