class RemoveColumnOrderAndAddColumn < ActiveRecord::Migration
  def up
    remove_column :vendors, :order
    add_column :vendors, :order, :integer
  end

  def down
    add_column :vendors, :order, :string
    remove_column :vendors, :order
  end
end
