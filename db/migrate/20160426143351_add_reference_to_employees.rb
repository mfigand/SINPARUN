class AddReferenceToEmployees < ActiveRecord::Migration
  def change
    add_reference :employees, :branch, index: true
     add_column :employees, :phone, :string
  end
end
