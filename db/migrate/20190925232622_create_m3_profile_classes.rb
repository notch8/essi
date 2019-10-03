class CreateM3ProfileClasses < ActiveRecord::Migration[5.1]
  def change
    create_table :m3_profile_classes do |t|
      t.string :name
      t.string :display_label
      t.string :schema_uri
      t.references :m3_profile, foreign_key: true
      t.references :m3_profile_property, foreign_key: true

      t.timestamps
    end
  end
end
