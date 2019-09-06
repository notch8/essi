class CreateM3Profiles < ActiveRecord::Migration[5.1]
  def change
    create_table :m3_profiles do |t|
      t.string :name
      t.integer :profile_version
      t.text :profile

      t.timestamps
    end
  end
end
