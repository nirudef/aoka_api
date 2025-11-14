class CreateBranches < ActiveRecord::Migration[8.0]
  def change
    create_table :branches, id: :uuid do |t|
      t.string :phone
      t.string :email
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6

      t.timestamps
    end
  end
end
