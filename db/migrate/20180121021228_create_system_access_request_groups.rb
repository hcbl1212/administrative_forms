class CreateSystemAccessRequestGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :system_access_request_groups do |t|
      t.integer :system_access_id
      t.integer :group_id

      t.timestamps
    end
  end
end
