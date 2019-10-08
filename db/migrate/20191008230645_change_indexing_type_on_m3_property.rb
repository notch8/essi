class ChangeIndexingTypeOnM3Property < ActiveRecord::Migration[5.1]
  def change
    def up
      change_column :m3_profile_properties, :indexing, :text, array: true, default: []
    end

    def down
      change_column :m3_profile_properties, :indexing, :string
    end
  end
end
