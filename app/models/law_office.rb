# app/models/law_office.rb
class LawOffice < ApplicationRecord
  has_many :translations, class_name: "LawOfficeTranslation", dependent: :destroy
  accepts_nested_attributes_for :translations, allow_destroy: true

  def translated(locale)
    translations.find_by(locale: locale.to_s) || translations.find_by(locale: "ru")
  end
end
