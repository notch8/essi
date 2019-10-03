class CreateM3Profiles < ActiveRecord::Migration[5.1]
  def change
    create_table :m3_profiles do |t|
      t.string :name
      t.integer :profile_version # version in m3
      t.text :profile
      t.string :m3_version
      t.string :responsibility
      t.string :responsibility_statement
      t.string :date_modified
      t.string :type

      t.timestamps
    end
  end
end
