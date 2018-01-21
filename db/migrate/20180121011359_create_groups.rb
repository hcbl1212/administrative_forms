class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.integer :signature_type
      t.string :signature

      t.timestamps
    end
  end
end
