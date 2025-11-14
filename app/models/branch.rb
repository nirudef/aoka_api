class Branch < ApplicationRecord
  translates :name, :address, :description, fallbacks_for_empty_translations: true
  # globalize_accessors locales: [:ru, :kk, :en], attributes: [:name, :address, :description]
end
