class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :iin, :string
    add_column :users, :phone, :string
    add_column :users, :license_number, :string
    add_column :users, :license_issued_at, :date
    add_column :users, :joined_at, :date
    add_column :users, :branch_id, :uuid
    add_column :users, :law_office_id, :uuid
    add_column :users, :address, :string
    add_column :users, :roles, :jsonb, default: []

    # Индексировать только непустые значения
    add_index :users, :branch_id, where: "branch_id IS NOT NULL"
    add_index :users, :law_office_id, where: "iin IS NOT NULL"

    # Уникальный индекс для IIN (тоже работает с NULL)
    add_index :users, :iin, unique: true

    # Внешние ключи (они автоматически допускают NULL, если не указано null: false)
    add_foreign_key :users, :branches, column: :branch_id
    # add_foreign_key :users, :law_offices, column: :law_office_id
  end
end