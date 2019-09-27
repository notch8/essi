class CreateM3ProfileTexts < ActiveRecord::Migration[5.1]
  def change
    create_table :m3_profile_texts do |t|
      t.string :name  # @todo required
      t.string :value
      t.references :m3_profile_property, foreign_key: true
    end
  end
end
