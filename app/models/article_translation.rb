class ArticleTranslation < ApplicationRecord
  belongs_to :article

  validates :locale, presence: true
  validates :title, :body, presence: true
  validates :locale, uniqueness: { scope: :article_id }

  # Поддерживаемые локали (настраиваемо)
  LOCALES = %w[ru kk en].freeze
  validates :locale, inclusion: { in: LOCALES }
end
