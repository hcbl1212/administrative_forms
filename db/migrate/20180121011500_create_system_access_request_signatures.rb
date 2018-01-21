class CreateSystemAccessRequestSignatures < ActiveRecord::Migration[5.1]
  def change
    create_table :system_access_request_signatures do |t|
      t.integer :system_access_request_id
      t.integer :signature_id

      t.timestamps
    end
  end
end
