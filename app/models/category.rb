class Category < ApplicationRecord
  # has_many :category_translations, dependent: :destroy
  has_many :translations, class_name: "CategoryTranslation", dependent: :destroy
  accepts_nested_attributes_for :translations, allow_destroy: true

  has_many :articles, dependent: :destroy
  # has_many :articles, through: :article_categories

  validates :key, presence: true, uniqueness: { case_sensitive: false }
  validates :key, format: { with: /\A[a-z_]+\z/, message: 'только строчные буквы и _' }

  # Получить название на нужном языке
  def name(locale = I18n.locale)
    translations.find { |t| t.locale == locale.to_s }&.name ||
      translations.first&.name ||
      key.humanize
  end

  # По умолчанию — важные категории для АОКА
  DEFAULT_CATEGORIES = [
    { key: 'news', names: { ru: 'Новости', kk: 'Жаңалықтар', en: 'News' } },
    { key: 'contest', names: { ru: 'Конкурсы', kk: 'Байқаулар', en: 'Contests' } },
    { key: 'announcement', names: { ru: 'Объявления', kk: 'Хабарландырулар', en: 'Announcements' } },
    { key: 'event', names: { ru: 'Мероприятия', kk: 'Іс-шаралар', en: 'Events' } },
    { key: 'legislation', names: { ru: 'Законодательство', kk: 'Заңнама', en: 'Legislation' } },
  ].freeze

  # Установить категории по умолчанию (вызвать один раз в seed)
  def self.seed_default!
    DEFAULT_CATEGORIES.each do |data|
      category = find_or_create_by!(key: data[:key])
      data[:names].each do |locale, name|
        category.category_translations.find_or_create_by!(locale: locale) do |t|
          t.name = name
        end
      end
    end
  end
end
