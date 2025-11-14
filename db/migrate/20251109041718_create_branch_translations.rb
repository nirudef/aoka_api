class CreateBranchTranslations < ActiveRecord::Migration[8.0]
  def change
    create_table :branch_translations, id: :uuid do |t|
      t.references :branch, foreign_key: true, type: :uuid
      t.string :name
      t.string :address
      t.text :description
      t.string :locale, null: false

      t.timestamps
    end
    add_index :branch_translations, [:branch_id, :locale], unique: true
  end
end
