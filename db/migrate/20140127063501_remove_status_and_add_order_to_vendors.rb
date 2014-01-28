class RemoveStatusAndAddOrderToVendors < ActiveRecord::Migration
  def up
    remove_column :vendors, :status
    add_column :vendors, :order, :string
  end

  def down
    add_column :vendors, :status, :boolean, :default => false
    remove_column :vendors, :order
  end
end
