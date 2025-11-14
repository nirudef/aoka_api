class CreateCategoryTranslations < ActiveRecord::Migration[8.0]
  def change
    create_table :category_translations, id: :uuid do |t|
      t.uuid :category_id, null: false
      t.string :locale, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :category_translations, [:category_id, :locale], unique: true
    add_foreign_key :category_translations, :categories, on_delete: :cascade
  end
end
