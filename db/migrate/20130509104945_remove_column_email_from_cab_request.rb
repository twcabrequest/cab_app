class RemoveColumnEmailFromCabRequest < ActiveRecord::Migration
  def up
    remove_column :cab_requests, :email
  end

  def down
    add_column :cab_requests, :email, :string
  end
end
