# # This file should ensure the existence of records required to run the application in every environment (production,
# # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Example:
# #
# #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
# #     MovieGenre.find_or_create_by!(name: genre_name)
# #   end
#
# Branch.destroy_all
# Branch::Translation.destroy_all
#
# branches = [
#   {
#     phone: '+7 (727) 300-45-67',
#     email: 'karasai@aoka.kz',
#     latitude: 43.2046,
#     longitude: 76.6236,
#     translations: {
#       ru: {
#         name: 'Карасайская юридическая консультация',
#         address: 'г. Каскелен, ул. Абая, 45',
#         description: 'Юридическая помощь гражданам и организациям Карасайского района.'
#       },
#       kk: {
#         name: 'Қарасай заң кеңес беру орталығы',
#         address: 'Қаскелең қ., Абай көш., 45',
#         description: 'Қарасай ауданындағы азаматтар мен ұйымдарға заң көмегі.'
#       },
#       en: {
#         name: 'Karasai Legal Consultation',
#         address: '45 Abai St., Kaskelen',
#         description: 'Legal assistance for citizens and organizations in the Karasai district.'
#       }
#     }
#   },
#   {
#     phone: '+7 (727) 350-11-22',
#     email: 'konaev@aoka.kz',
#     latitude: 43.8694,
#     longitude: 77.0113,
#     translations: {
#       ru: {
#         name: 'Консультация г. Конаева',
#         address: 'г. Конаев, пр. Абылай хана, 12',
#         description: 'Филиал Коллегии адвокатов в административном центре области.'
#       },
#       kk: {
#         name: 'Қонаев қаласы заң кеңес беру орталығы',
#         address: 'Қонаев қ., Абылай хан даңғ., 12',
#         description: 'Аймақтың әкімшілік орталығындағы адвокаттар филиалы.'
#       },
#       en: {
#         name: 'Konaev City Consultation',
#         address: '12 Abylai Khan Ave., Konaev',
#         description: 'Regional branch of the Bar Association in the administrative center.'
#       }
#     }
#   },
#   {
#     phone: '+7 (727) 355-77-90',
#     email: 'talgar@aoka.kz',
#     latitude: 43.3057,
#     longitude: 77.2341,
#     translations: {
#       ru: {
#         name: 'Талгарская юридическая консультация',
#         address: 'г. Талгар, ул. Рыскулова, 20',
#         description: 'Оказывает адвокатские услуги жителям Талгарского района.'
#       },
#       kk: {
#         name: 'Талғар заң кеңес беру орталығы',
#         address: 'Талғар қ., Рысқұлов көш., 20',
#         description: 'Талғар ауданы тұрғындарына заң көмегін көрсетеді.'
#       },
#       en: {
#         name: 'Talgar Legal Consultation',
#         address: '20 Ryskulov St., Talgar',
#         description: 'Provides legal services to residents of Talgar district.'
#       }
#     }
#   },
#   {
#     phone: '+7 (727) 330-22-10',
#     email: 'kapshagai@aoka.kz',
#     latitude: 43.8663,
#     longitude: 77.0735,
#     translations: {
#       ru: {
#         name: 'Капшагайская юридическая консультация',
#         address: 'г. Капшагай, ул. Назарбаева, 10',
#         description: 'Правовая помощь гражданам и предприятиям города Капшагая.'
#       },
#       kk: {
#         name: 'Қапшағай заң кеңес беру орталығы',
#         address: 'Қапшағай қ., Назарбаев көш., 10',
#         description: 'Қапшағай қаласының тұрғындары мен кәсіпорындарына құқықтық көмек.'
#       },
#       en: {
#         name: 'Kapshagai Legal Consultation',
#         address: '10 Nazarbayev St., Kapshagai',
#         description: 'Legal support for citizens and businesses in Kapshagai.'
#       }
#     }
#   },
#   {
#     phone: '+7 (727) 340-12-34',
#     email: 'yesik@aoka.kz',
#     latitude: 43.3526,
#     longitude: 77.4658,
#     translations: {
#       ru: {
#         name: 'Есикская юридическая консультация',
#         address: 'г. Есик, ул. Толе би, 9',
#         description: 'Филиал, обслуживающий Енбекшиказахский район.'
#       },
#       kk: {
#         name: 'Есік заң кеңес беру орталығы',
#         address: 'Есік қ., Төле би көш., 9',
#         description: 'Еңбекшіқазақ ауданындағы филиал.'
#       },
#       en: {
#         name: 'Yesik Legal Consultation',
#         address: '9 Tole Bi St., Yesik',
#         description: 'Serving the Enbekshikazakh district.'
#       }
#     }
#   },
#   {
#     phone: '+7 (727) 320-56-78',
#     email: 'zhetysu@aoka.kz',
#     latitude: 43.2383,
#     longitude: 76.9455,
#     translations: {
#       ru: {
#         name: 'Жетысуская юридическая консультация',
#         address: 'г. Алматы, ул. Байтурсынова, 100',
#         description: 'Юридическая консультация для адвокатов и клиентов Жетысуского района.'
#       },
#       kk: {
#         name: 'Жетісу заң кеңес беру орталығы',
#         address: 'Алматы қ., Байтурсынов көш., 100',
#         description: 'Жетісу ауданындағы адвокаттар мен клиенттерге арналған заң орталығы.'
#       },
#       en: {
#         name: 'Zhetysu Legal Consultation',
#         address: '100 Baytursynov St., Almaty',
#         description: 'Legal consultation for lawyers and clients in the Zhetysu district.'
#       }
#     }
#   }
# ]
#
# branches.each do |data|
#   translations = data.delete(:translations)
#   branch = Branch.create!(data)
#   translations.each do |locale, attrs|
#     branch.translations.create!(attrs.merge(locale: locale))
#   end
# end
#
# puts "✅ Created #{Branch.count} branches with translations"


# db/seeds.rb
require 'faker'

Faker::Config.locale = 'ru'

puts "Очистка старых данных..."
# User.destroy_all
# LawOfficeTranslation.destroy_all
# LawOffice.destroy_all
# BranchTranslation.destroy_all
# Branch.destroy_all

# puts "Создание филиалов..."
# branches = [
#   {
#     phone: "+7 727 123 4567",
#     email: "almaty@pravoved.kz",
#     latitude: 43.238949,
#     longitude: 76.889709,
#     translations: {
#       ru: { name: "Алматинский филиал", address: "г. Алматы, ул. Абая 10", description: "Основной филиал компании" },
#       kk: { name: "Алматы филиалы", address: "Алматы қ., Абай к-сі 10", description: "Компанияның негізгі филиалы" },
#       en: { name: "Almaty Branch", address: "10 Abay St, Almaty", description: "Main branch of the company" }
#     }
#   },
#   {
#     phone: "+7 7172 987 654",
#     email: "astana@pravoved.kz",
#     latitude: 51.169392,
#     longitude: 71.449074,
#     translations: {
#       ru: { name: "Астанинский филиал", address: "г. Астана, пр. Абая 20", description: "Филиал в столице" },
#       kk: { name: "Астана филиалы", address: "Астана қ., Абай д-лы 20", description: "Елордадағы филиал" },
#       en: { name: "Astana Branch", address: "20 Abay Ave, Astana", description: "Capital branch" }
#     }
#   }
# ]
#
# branches.each do |data|
#   branch = Branch.create!(
#     phone: data[:phone],
#     email: data[:email],
#     latitude: data[:latitude],
#     longitude: data[:longitude]
#   )
#
#   data[:translations].each do |locale, t|
#     branch.translations.create!(
#       locale: locale.to_s,
#       name: t[:name],
#       address: t[:address],
#       description: t[:description]
#     )
#   end
# end

# require "faker"

# puts "Очистка базы..."
# User.destroy_all
# LawOffice.destroy_all
# Branch.destroy_all

# puts "Создание филиалов..."

# branches = [
#   {
#     translations: {
#       ru: { name: "Алматинский филиал", address: "г. Алматы, ул. Абая, 25", description: "Основной филиал Коллегии" },
#       kk: { name: "Алматы филиалы", address: "Алматы қ., Абай көш., 25", description: "Коллегияның негізгі филиалы" },
#       en: { name: "Almaty Branch", address: "25 Abay St, Almaty", description: "Main branch of the Bar Association" }
#     },
#     phone: "+7 (727) 123-4567",
#     email: "almaty@bar.kz"
#   },
#   {
#     translations: {
#       ru: { name: "Астанинский филиал", address: "г. Астана, пр. Туран, 10", description: "Филиал в столице" },
#       kk: { name: "Астана филиалы", address: "Астана қ., Тұран даңғ., 10", description: "Астанадағы филиал" },
#       en: { name: "Astana Branch", address: "10 Turan Ave, Astana", description: "Capital branch" }
#     },
#     phone: "+7 (7172) 987-654",
#     email: "astana@bar.kz"
#   }
# ]
#
# branches.each do |b|
#   branch = Branch.create!(
#     phone: b[:phone],
#     email: b[:email]
#   )
#   b[:translations].each do |locale, data|
#     branch.translations.create!(locale: locale, **data)
#   end
# end

# puts "Создание адвокатских контор..."
#
# law_offices_data = [
#   {
#     translations: {
#       ru: { name: "Адвокатская контора «Право и Защита»", address: "г. Алматы, ул. Достык, 88", description: "Объединение адвокатов индивидуалов" },
#       kk: { name: "«Құқық және Қорғау» адвокаттар кеңсесі", address: "Алматы қ., Достық к-сі, 88", description: "Жеке адвокаттардың бірлестігі" },
#       en: { name: "Law Office 'Pravo i Zashchita'", address: "88 Dostyk St, Almaty", description: "Union of independent advocates" }
#     },
#     phone: "+7 (727) 555-7788",
#     email: "info@pravo.kz"
#   },
#   {
#     translations: {
#       ru: { name: "Адвокатская контора «ЮрЭксперт»", address: "г. Астана, ул. Кабанбай батыра, 11", description: "Юридическая помощь по гражданским делам" },
#       kk: { name: "«ЮрЭксперт» адвокаттар кеңсесі", address: "Астана қ., Қабанбай батыр к-сі, 11", description: "Азаматтық істер бойынша заң көмегі" },
#       en: { name: "Law Office 'JurExpert'", address: "11 Kabanbai Batyr St, Astana", description: "Civil law specialists" }
#     },
#     phone: "+7 (7172) 333-229",
#     email: "info@jurexpert.kz"
#   }
# ]
#
# law_offices = law_offices_data.map do |lo|
#   office = LawOffice.create!(
#     phone: lo[:phone],
#     email: lo[:email]
#   )
#   lo[:translations].each do |locale, data|
#     office.translations.create!(locale: locale, **data)
#   end
#   office
# end
#
# puts "Создание пользователей..."
#
# branches = Branch.all
# users_data = [
#   {
#     first_name: "Игорь",
#     last_name: "Федурин",
#     middle_name: "Александрович",
#     iin: "800101300123",
#     phone: "+7 701 111 2233",
#     email: "igor@example.com",
#     password: "password123123",
#     license_number: "A-001",
#     license_issued_at: Date.new(2010, 1, 1),
#     joined_at: Date.new(2010, 2, 1),
#     branch: branches.first,
#     roles: ["advocate"]
#   },
#   {
#     first_name: "Анна",
#     last_name: "Ким",
#     middle_name: "Сергеевна",
#     iin: "820202400456",
#     phone: "+7 702 333 4455",
#     email: "anna@example.com",
#     password: "password123123",
#     license_number: "A-002",
#     license_issued_at: Date.new(2012, 3, 5),
#     joined_at: Date.new(2012, 4, 1),
#     branch: branches.last,
#     roles: ["advocate", "branch_head"]
#   },
#   {
#     first_name: "Роман",
#     last_name: "Журавлёв",
#     middle_name: nil,
#     iin: "900303500789",
#     phone: "+7 705 555 6677",
#     email: "roman@example.com",
#     password: "password123123",
#     license_number: "A-003",
#     license_issued_at: Date.new(2015, 6, 10),
#     joined_at: Date.new(2015, 7, 1),
#     law_office: law_offices.first,
#     roles: ["advocate"]
#   }
# ]
#
# users_data.each do |data|
#   user = User.create!(
#     first_name: data[:first_name],
#     last_name: data[:last_name],
#     middle_name: data[:middle_name],
#     iin: data[:iin],
#     phone: data[:phone],
#     email: data[:email],
#     password: data[:password],
#     license_number: data[:license_number],
#     license_issued_at: data[:license_issued_at],
#     joined_at: data[:joined_at],
#     branch: data[:branch],
#     law_office: data[:law_office],
#     roles: data[:roles]
#   )
#   puts "Создан пользователь: #{user.last_name} #{user.first_name} (#{user.roles.join(', ')})"
# end
#
# puts "Создание администратора..."
#
User.create!(
  first_name: "Админ",
  last_name: "Системный",
  middle_name: nil,
  iin: "750101600999",
  phone: "+7 700 000 0000",
  email: "admin@bar.kz",
  password: "admin123123!",
  roles: ["admin"]
)
#
# puts "✅ Сиды успешно загружены!"

# db/seeds.rb
# puts "🌱 Запуск сидов АОКА..."
# Article.destroy_all
# Category.destroy_all
#
# # 1. Создаём категории
# CATEGORIES = [
#   { key: 'news', names: { ru: 'Новости', kk: 'Жаңалықтар', en: 'News' } },
#   { key: 'contest', names: { ru: 'Конкурсы', kk: 'Байқаулар', en: 'Contests' } },
#   { key: 'announcement', names: { ru: 'Объявления', kk: 'Хабарландырулар', en: 'Announcements' } },
#   { key: 'event', names: { ru: 'Мероприятия', kk: 'Іс-шаралар', en: 'Events' } },
#   { key: 'legislation', names: { ru: 'Законодательство', kk: 'Заңнама', en: 'Legislation' } },
# ].freeze
#
# categories = {}
# CATEGORIES.each do |data|
#   category = Category.create!(
#     key: data[:key],
#     position: CATEGORIES.index(data)
#   )
#
#   data[:names].each do |locale, name|
#     CategoryTranslation.create!(
#       category: category,
#       locale: locale,
#       name: name
#     )
#   end
#
#   categories[data[:key]] = category
#   puts "✅ Категория: #{data[:key]} (#{data[:names][:ru]})"
# end
#
# # 2. Вспомогательная функция для slug через friendly_id
# def generate_slug(title_ru)
#   # Транслитерация через I18n (более надёжная)
#   slug = I18n.transliterate(title_ru, locale: :ru)
#              .downcase
#              .gsub(/[^a-z0-9\s\-]/, '')
#              .gsub(/\s+/, '-')
#              .gsub(/-+/, '-')
#              .gsub(/^-|-$/, '')
#
#   # Если slug пустой, генерируем случайный
#   slug = "article-#{SecureRandom.hex(4)}" if slug.blank?
#
#   # Проверка уникальности
#   original_slug = slug
#   counter = 2
#   while Article.exists?(slug: slug)
#     slug = "#{original_slug}-#{counter}"
#     counter += 1
#   end
#
#   slug
# end
#
# # def generate_slug(title_ru)
# #   # Имитируем friendly_id.normalize_friendly_id
# #   text = title_ru
# #            .gsub(/ә|а́/, 'a').gsub(/ғ|ѓ/, 'g').gsub(/қ|ќ/, 'k')
# #            .gsub(/ң|н́/, 'n').gsub(/ө|о́/, 'o').gsub(/ұ|у́/, 'u')
# #            .gsub(/ү|ы́/, 'u').gsub(/һ|х́/, 'h').gsub(/і|и́/, 'i')
# #            .gsub(/й/, 'y').gsub(/[ъь]/, '')
# #   text = I18n.transliterate(text, locale: :ru)
# #   text.downcase.gsub(/[^a-z0-9\s\-]/, '').gsub(/\s+/, '-').gsub(/-+/, '-').gsub(/^-|-$/, '')
# # end
#
# # 3. Статьи
# ARTICLES = [
#   {
#     key: :contest,
#     ru: {
#       title: 'Конкурс молодых адвокатов 2025',
#       lead: 'АОКА объявляет о проведении ежегодного конкурса для начинающих юристов.',
#       body: '<p>Конкурс направлен на выявление и поддержку талантливых молодых специалистов. Приём заявок до 15 апреля 2025 года.</p>',
#       meta_title: 'Конкурс молодых адвокатов — АОКА',
#       meta_description: 'Принимайте участие в конкурсе молодых адвокатов 2025 года!'
#     },
#     kk: {
#       title: 'Жас адвокаттар байқауы 2025',
#       lead: 'АОКА жас заңгерлер арасында жыл сайынғы байқауды жариялайды.',
#       body: '<p>Байқау талантты жас мамандарды анықтау және қолдау мақсатын көздейді. Өтініштерді 2025 жылғы 15 сәуірге дейін қабылдаймыз.</p>',
#       meta_title: 'Жас адвокаттар байқауы — АОКА',
#       meta_description: '2025 жылғы жас адвокаттар байқауына қатысыңыз!'
#     },
#     en: {
#       title: 'Young Lawyers Contest 2025',
#       lead: 'AOKA announces the annual contest for young lawyers.',
#       body: '<p>The contest aims to identify and support talented young professionals. Applications accepted until April 15, 2025.</p>',
#       meta_title: 'Young Lawyers Contest — AOKA',
#       meta_description: 'Join the Young Lawyers Contest 2025!'
#     },
#     published_at: 1.week.ago
#   },
#
#   {
#     key: :news,
#     ru: {
#       title: 'Новый состав Совета Коллегии',
#       lead: 'Избран новый состав Совета Алматинской областной коллегии адвокатов.',
#       body: '<p>На отчётно-выборной конференции 10 марта 2025 года избран новый состав Совета АОКА во главе с Сакеном Махышевым.</p>',
#       meta_title: 'Совет АОКА — Алматинская областная коллегия адвокатов',
#       meta_description: 'Новый состав Совета АОКА избран на конференции.'
#     },
#     kk: {
#       title: 'Коллегия Кеңесінің жаңа құрамы',
#       lead: 'Алматы облыстық адвокаттар коллегиясы Кеңесінің жаңа құрамы сайланды.',
#       body: '<p>2025 жылғы 10 наурызда есеп-сайлау конференциясында Сакен Маһышев бастаған АОКА Кеңесінің жаңа құрамы сайланды.</p>',
#       meta_title: 'АОКА Кеңесі',
#       meta_description: 'Конференцияда АОКА Кеңесінің жаңа құрамы сайланды.'
#     },
#     en: {
#       title: 'New Board of the Bar Association',
#       lead: 'The new Board of Almaty Regional Bar Association has been elected.',
#       body: '<p>At the reporting and election conference on March 10, 2025, the new AOKA Board headed by Saken Mahyshev was elected.</p>',
#       meta_title: 'AOKA Board',
#       meta_description: 'New AOKA Board elected at the conference.'
#     },
#     published_at: 2.days.ago
#   },
#
#   {
#     key: :legislation,
#     ru: {
#       title: 'Қылмыс сот әділеттілігі Изменения в Уголовно-процессуальном кодексе',
#       lead: 'С 1 апреля 2025 года вступают в силу поправки в УПК РК.',
#       body: '<p>Поправки касаются упрощения производства по делам частного обвинения и усиления прав защиты.</p>',
#       meta_title: 'Изменения в УПК РК — АОКА',
#       meta_description: 'Новые поправки в Уголовно-процессуальный кодекс с 1 апреля 2025.'
#     },
#     kk: {
#       title: 'Қылмыс сот әділеттілігі кодексіндегі өзгерістер',
#       lead: 'ҚР ҚСӘК-не 2025 жылғы 1 сәуірден бастап өзгерістер енгізіледі.',
#       body: '<p>Өзгерістер жеке айыптаулар бойынша істерді қарапайымдату және қорғаныс құқықтарын нығайтуға қатысты.</p>',
#       meta_title: 'ҚСӘК-не өзгерістер — АОКА',
#       meta_description: '2025 жылғы 1 сәуірден Қылмыс сот әділеттілігі кодексіне өзгерістер кіреді.'
#     },
#     en: {
#       title: 'Amendments to the Criminal Procedure Code',
#       lead: 'Amendments to the CPC of the RK enter into force on April 1, 2025.',
#       body: '<p>The amendments simplify proceedings in private prosecution cases and strengthen defense rights.</p>',
#       meta_title: 'CPC Amendments — AOKA',
#       meta_description: 'New amendments to the Criminal Procedure Code effective April 1, 2025.'
#     },
#     published_at: Time.current
#   }
# ].freeze
#
# # 4. Создаём статьи
# ARTICLES.each_with_index do |data, index|
#   # title = data[:ru][:title]
#   # slug = generate_slug(title)
#   #
#   # puts "🔍 Отладка:"
#   # puts "   Заголовок: #{title}"
#   # puts "   Slug: #{slug}"
#
#   begin
#     # Создаём статью вместе с переводами через accepts_nested_attributes
#     # Или используем транзакцию для атомарности
#     article = nil
#
#     Article.transaction do
#       article = Article.new(
#         # slug: generate_slug(data[:ru][:title]),
#         status: 'published',
#         published_at: data[:published_at],
#         category: categories[data[:key]]
#       )
#
#       # Создаём переводы ДО сохранения статьи
#       %w[ru kk en].each do |locale|
#         trans = data[locale.to_sym]
#         article.article_translations.build(
#           locale: locale,
#           title: trans[:title],
#           lead: trans[:lead],
#           body: trans[:body],
#           meta_title: trans[:meta_title],
#           meta_description: trans[:meta_description]
#         )
#       end
#
#       # Теперь сохраняем статью вместе с переводами
#       article.save!
#     end
#
#     puts "✅ Статья: #{data[:ru][:title]} → /#{article.slug}"
#
#   rescue ActiveRecord::RecordInvalid => e
#     puts "❌ Ошибка при создании статьи ##{index + 1}:"
#     puts "   Данные: #{data[:ru][:title]}"
#     puts "   Ошибка: #{e.message}"
#     puts "   Детали: #{e.record.errors.full_messages.join(', ')}"
#     raise e
#   end
# end
#
#
# # end
#
# puts "🚀 Сиды успешно загружены!"
# puts "👉 Проверьте в консоли:"
# puts "   Article.first.slug"
# puts "   Article.first.category.name('ru')"
# puts "   Article.published.count"
