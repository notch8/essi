class CreateM3Contexts < ActiveRecord::Migration[5.1]
  def change
    create_table :m3_contexts do |t|
      t.string :name
      t.string :admin_set_ids
      t.references :m3_profile, foreign_key: true

      t.timestamps
    end
  end
end
