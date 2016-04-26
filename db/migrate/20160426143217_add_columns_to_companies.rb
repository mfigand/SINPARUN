class AddColumnsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :phone, :string
    add_column :companies, :description, :text
    add_column :companies, :url, :string
  end
end
