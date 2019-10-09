class CreateM3ProfileAvailableProperty < ActiveRecord::Migration[5.1]
  def change
    create_table :m3_profile_available_properties do |t|
      t.references :m3_profile_property, foreign_key: true, index: { name: 'index_m3_available_properties_on_m3_property_id' }
    
      t.timestamps
    end
  end
end
