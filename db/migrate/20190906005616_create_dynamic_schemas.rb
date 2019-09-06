class CreateDynamicSchemas < ActiveRecord::Migration[5.1]
  def change
    create_table :dynamic_schemas do |t|
      t.integer :version
      t.string :m3class
      t.references :m3_context, foreign_key: true
      t.references :m3_profile, foreign_key: true
      t.integer :profile_version
      t.json :schema

      t.timestamps
    end
  end
end
