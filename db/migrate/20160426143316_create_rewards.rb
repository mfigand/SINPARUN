class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.string :name
      t.integer :kms_cost
      t.string :code
      t.text :description
      t.datetime :valid_from
      t.datetime :valid_through
      t.integer :available_units
      t.integer :reserved_units, default: 0
      t.integer :charged_units, default: 0
      t.references :company, index: true
      t.references :branch, index: true

      t.timestamps null: false
    end
  end
end
