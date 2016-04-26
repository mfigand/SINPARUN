class CreateKms < ActiveRecord::Migration
  def change
    create_table :kms do |t|
      t.integer :sinparun_kms, default: 0
      t.integer :total_kms, default: 0
      t.integer :nike_last_total_kms, default: 0
      t.integer :runtastic_last_total_kms, default: 0
      t.integer :level, default: 0
      t.integer :races, default: 0
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
