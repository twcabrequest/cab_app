class AddRequestedVendorToCabRequests < ActiveRecord::Migration
  def change
    add_column :cab_requests, :requested_vendor, :int
  end
end
