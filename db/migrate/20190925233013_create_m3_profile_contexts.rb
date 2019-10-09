class CreateM3ProfileContexts < ActiveRecord::Migration[5.1]
  def change
    create_table :m3_profile_contexts do |t|
      t.string :name
      t.string :display_label
      t.references :m3_profile, foreign_key: true

      t.timestamps
    end
  end
end
