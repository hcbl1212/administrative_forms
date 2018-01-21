class CreateSignatures < ActiveRecord::Migration[5.1]
  def change
    create_table :signatures do |t|
      t.integer :signature_type
      t.integer :system_access_request_id
      t.string :signature
      t.datetime :date

      t.timestamps
    end
  end
end
