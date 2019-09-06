class CreateM3Contexts < ActiveRecord::Migration[5.1]
  def change
    create_table :m3_contexts do |t|
      t.string :name

      t.timestamps
    end
  end
end
