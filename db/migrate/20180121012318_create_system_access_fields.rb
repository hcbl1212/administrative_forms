class CreateSystemAccessFields < ActiveRecord::Migration[5.1]
  def change
    create_table :system_access_fields do |t|
      t.text :name

      t.timestamps
    end
  end
end
