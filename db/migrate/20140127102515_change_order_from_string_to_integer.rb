class ChangeOrderFromStringToInteger < ActiveRecord::Migration
  def up
    change_column :vendors, :order, :integer
  end

  def down
    change_column :vendors, :order, :string
  end
end
