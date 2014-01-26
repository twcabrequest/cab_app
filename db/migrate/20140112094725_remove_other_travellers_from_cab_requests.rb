class RemoveOtherTravellersFromCabRequests < ActiveRecord::Migration
  def up
    remove_column :cab_requests, :project
  end

  def down
    add_column :cab_requests, :project, :varchar
  end
end
