class CategoryTranslation < ApplicationRecord
  belongs_to :category

  validates :locale, presence: true, inclusion: { in: %w[ru kk en] }
  validates :name, presence: true
  validates :locale, uniqueness: { scope: :category_id }
end
