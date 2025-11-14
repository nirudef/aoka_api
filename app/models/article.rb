
class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title_for_slug, use: [:slugged, :finders]

  has_many :translations, class_name: "ArticleTranslation", dependent: :destroy
  accepts_nested_attributes_for :translations, allow_destroy: true

  # ✅ globalize — подключаем переводы
  # translates :title, :lead, :body, :meta_title, :meta_description,
  #            fallbacks_for_empty_translations: false
  #
  # # ✅ fallback на русский, если нет перевода
  # locale_fallbacks = {
  #   'kk' => ['kk', 'ru', 'en'],
  #   'en' => ['en', 'ru', 'kk'],
  #   'ru' => ['ru', 'kk', 'en']
  # }
  # translates :title, :lead, :body, :meta_title, :meta_description,
  #            fallbacks: locale_fallbacks

  # Статусы
  enum :status, { draft: 'draft', published: 'published', archived: 'archived' }, prefix: :status

  # Связи
  # has_many :article_translations, dependent: :destroy
  belongs_to :category, optional: true

  # Валидации
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :published_at, presence: true, if: :status_published?

  # Scopes
  scope :published, ->(time = Time.current) {
    where(status: :published)
      .where('published_at <= ?', time)
      .order(published_at: :desc)
  }

  scope :by_category, ->(category_key) {
    joins(:category).where(categories: { key: category_key })
  }

  # Удобный метод получения перевода
  def translate(locale)
    translations.find_by(locale:)&.slice(:title, :lead, :body, :meta_title, :meta_description)
  end

  # Генерация slug из перевода на русском
  def title_for_slug
    # Используем русский перевод для генерации slug
    trans = translations.find { |t| t.locale == 'ru' } ||
            translations.first

    if trans&.title.present?
      trans.title
    else
      # Фолбэк только если переводов вообще нет
      "article-#{SecureRandom.hex(4)}"
    end
  end

  # Кастомная транслитерация для русского и казахского
  def normalize_friendly_id(text)
    text = text
             .gsub('ә', 'a').gsub('Ә', 'A')
             .gsub('ғ', 'g').gsub('Ғ', 'G')
             .gsub('қ', 'k').gsub('Қ', 'K')
             .gsub('ң', 'n').gsub('Ң', 'N')
             .gsub('ө', 'o').gsub('Ө', 'O')
             .gsub('ұ', 'u').gsub('Ұ', 'U')
             .gsub('ү', 'u').gsub('Ү', 'U')
             .gsub('һ', 'h').gsub('Һ', 'H')
             .gsub('і', 'i').gsub('І', 'I')

    text.to_slug.transliterate(:russian).normalize.to_s
  end

  # Разрешаем friendly_id генерировать slug при создании
  def should_generate_new_friendly_id?
    slug.blank? || title_for_slug_changed?
  end

  private

  def title_for_slug_changed?
    # Проверяем, изменился ли русский заголовок
    trans = translations.find { |t| t.locale == 'ru' }
    trans&.title_previously_changed? || trans&.title_changed?
  end
end
