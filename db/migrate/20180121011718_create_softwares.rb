class CreateSoftwares < ActiveRecord::Migration[5.1]
  def change
    create_table :softwares do |t|
      t.text :name

      t.timestamps
    end
  end
end
