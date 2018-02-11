class AddStateToSystemAccessRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :system_access_requests, :state, :integer
  end
end
