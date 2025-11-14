class CreateArticleTranslations < ActiveRecord::Migration[8.0]
  def change
    create_table :article_translations, id: :uuid do |t|
      t.uuid :article_id, null: false
      t.string :locale, null: false
      t.string :title, null: false
      t.text :lead
      t.text :body, null: false
      t.string :meta_title
      t.string :meta_description

      t.timestamps
    end

    add_index :article_translations, [:article_id, :locale], unique: true
    add_foreign_key :article_translations, :articles, on_delete: :cascade
  end
end
