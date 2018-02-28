class CreateExternalActionAuthorizations < ActiveRecord::Migration[5.1]
  def change
    create_table :external_action_authorizations do |t|
      t.text :authorization_code
      t.integer :system_access_request_id
      t.integer :state

      t.timestamps
    end
  end
end
