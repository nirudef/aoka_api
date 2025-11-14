class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles, id: :uuid do |t|
      t.string :slug, null: false
      t.string :status, default: 'draft', null: false
      t.datetime :published_at
      t.uuid :category_id

      t.timestamps
    end
    add_index :articles, :slug, unique: true
    add_index :articles, :status
    add_index :articles, :published_at
    add_index :articles, :category_id
    add_foreign_key :articles, :categories, column: :category_id, on_delete: :nullify
  end
end
