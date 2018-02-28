class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.text :name
      t.integer :group_type

      t.timestamps
    end
  end
end
