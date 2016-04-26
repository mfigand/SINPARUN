class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :kms_cost
      t.string :redeemed
      t.references :user, index: true
      t.references :employee, index: true
      t.references :reward, index: true

      t.timestamps null: false
    end
  end
end
