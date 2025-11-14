# app/models/law_office_translation.rb
class LawOfficeTranslation < ApplicationRecord
  belongs_to :law_office
  validates :locale, presence: true
end
