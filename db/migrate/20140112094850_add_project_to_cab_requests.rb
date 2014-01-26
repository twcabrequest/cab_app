class AddProjectToCabRequests < ActiveRecord::Migration
  def up
    add_column :cab_requests, :project, :varchar
  end

  def down
    remove_column :cab_requests, :project
  end
end