class AddSubmitterIdToSignature < ActiveRecord::Migration[5.1]
  def change
    add_column :signatures, :submitter_id, :integer
  end
end
