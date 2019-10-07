class AddDefaultVersionToM3Profiles < ActiveRecord::Migration[5.1]
  def up
    change_column :m3_profiles, :profile_version, :integer, default: 0
  end

  def down
    change_column :m3_profiles, :profile_version, :integer, default: nil
  end
end
