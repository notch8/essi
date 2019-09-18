class ChangeProfileVersionToBeFloatInM3Profiles < ActiveRecord::Migration[5.1]
  def change
    change_column :m3_profiles, :profile_version, :float
  end
end
