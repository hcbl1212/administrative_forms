class CreateResources < ActiveRecord::Migration[5.1]
  def change
    create_table :resources do |t|
      t.text :name
      t.string :url
      t.integer :resource_type

      t.timestamps
    end
  end
end
