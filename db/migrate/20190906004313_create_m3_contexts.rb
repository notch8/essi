class CreateM3Contexts < ActiveRecord::Migration[5.1]
  def change
    create_table :m3_contexts do |t|
      t.string :name
      t.string :admin_set_ids
      t.string :m3_context_name
      t.references :m3_profile, foreign_key: true
      t.references :m3_profile_context, foreign_key: true

      t.timestamps
    end
  end
end
