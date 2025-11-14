class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :key, null: false
      t.integer :position, default: 0
      t.timestamps
    end

    add_index :categories, :key, unique: true
    add_index :categories, :position
  end
end
