class CreateSoftwareRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :software_roles do |t|
      t.integer :software_id
      t.integer :role_id

      t.timestamps
    end
  end
end
