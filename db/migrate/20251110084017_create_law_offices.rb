class CreateLawOffices < ActiveRecord::Migration[8.0]
  def change
    create_table :law_offices, id: :uuid do |t|
      t.string :phone
      t.string :email
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.timestamps
    end

    create_table :law_office_translations, id: :uuid do |t|
      t.uuid :law_office_id
      t.string :name
      t.string :address
      t.text :description
      t.string :locale, null: false
      t.timestamps

      t.index [:law_office_id, :locale], unique: true
      t.index :law_office_id
    end
  end
end
