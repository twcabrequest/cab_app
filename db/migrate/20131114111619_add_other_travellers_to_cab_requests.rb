class AddOtherTravellersToCabRequests < ActiveRecord::Migration
  def change
    add_column :cab_requests, :project, :string
  end
end
