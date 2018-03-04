class CreateSignatures < ActiveRecord::Migration[5.1]
  def change
    create_table :signatures do |t|
      t.integer :signature_type
      t.integer :system_access_request_id
      t.text :signature
      t.date :date

      t.timestamps
    end
  end
end
