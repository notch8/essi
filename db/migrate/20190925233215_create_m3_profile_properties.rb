class CreateM3ProfileProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :m3_profile_properties do |t|
      t.string :name # @todo required
      t.string :property_uri
      t.integer :cardinality_minimum
      t.integer :cardinality_maximum
      t.string :indexing # serialize as array
      t.references :m3_profile, foreign_key: true

      t.timestamps
    end
  end
end
