class AddJsonSchemaToM3Profiles < ActiveRecord::Migration[5.1]
  def change
    add_column :m3_profiles, :json_schema, :text
  end
end
