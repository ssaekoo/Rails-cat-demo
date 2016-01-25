class CreateToys < ActiveRecord::Migration
  def change
    create_table :toys do |t|
      t.integer :cat_id, null: false
      t.string :name, null: false
      t.string :model, null: false

      t.timestamps
    end
  end
end
