# frozen_string_literal: true

class Api::V1::ArticlesController < ApplicationController
  skip_before_action :authenticate
  # before_action :require_admin, only: [:create, :update, :destroy]
  before_action :set_article, only: [:show, :update, :destroy]

  # GET /api/v1/articles?lang=ru&category=news&page=1
  def index
    lang = params[:lang]&.in?(%w[ru kk en]) || 'ru'
    category_key = params[:category]

    @articles = Article.published
                       .includes(:category, translations: :article)

    @articles = @articles.joins(:category).where(categories: { key: category_key }) if category_key

    @articles = @articles.page(params[:page]).per(10)
    p @articles.inspect

    render json: {
      articles: @articles.map { |a| serialize_article(a, lang) },
      meta: {
        current_page: @articles.current_page,
        total_pages: @articles.total_pages,
        total_count: @articles.total_count
      }
    }
  end

  # GET /api/v1/articles/:slug?lang=ru
  # def show
  #   lang = params[:lang]&.in?(%w[ru kk en]) || 'ru'
  #
  #   # Определяем, запрашивается ли редактирование (например, по заголовку или параметру)
  #   # Вариант A: по заголовку Accept: application/json+edit
  #   # Вариант B: проще — по ?edit=1
  #   is_edit = params[:edit] == '1'
  #
  #   if is_edit
  #     render json: serialize_article_for_edit(@article)
  #   else
  #     render json: serialize_article(@article, lang)
  #   end
  # end
  def show
    lang = params[:lang]&.in?(%w[ru kk en]) || 'ru'

    # 🔹 Проверяем, запрашивается ли редактирование
    if params[:edit] == '1'
      render json: serialize_article_for_edit(@article)
    else
      render json: serialize_article(@article, lang)
    end
  end

  # POST /api/v1/articles
  def create
    @article = Article.new(article_params)

    if @article.save
      save_translations(@article, translations_params)
      render json: serialize_article(@article, 'ru'), status: :created
    else
      render json: { error: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/articles/:id
  def update
    if @article.update(article_params)
      save_translations(@article, translations_params)
      render json: { success: true }
    else
      render json: { error: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/articles/:id
  def destroy
    @article.destroy!
    head :no_content
  end

  private

  def set_article
    @article = Article.friendly.find(params[:slug])
    # @article = Article.find_by!(slug: params[:slug]) || Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(
      :slug, :status, :published_at, :category_id,
      translations: [:locale, :title, :lead, :body, :meta_title, :meta_description]
    ).tap do |p|
      p[:translations]&.each do |t|
        t[:body] = sanitize_html(t[:body]) if t[:body].is_a?(String)
      end
    end
  end

  def sanitize_html(html)
    Sanitize.fragment(html, Sanitize::Config::RELAXED.merge(
      elements: %w[div p h1 h2 h3 h4 h5 h6 br ul ol li blockquote strong em a img table thead tbody tr th td],
      attributes: {
        'a' => ['href', 'target'],
        'img' => ['src', 'alt', 'width', 'height'],
        'table' => ['border', 'cellpadding', 'cellspacing'],
        'td' => ['colspan', 'rowspan']
      },
      protocols: {
        'a' => { 'href' => ['http', 'https', 'mailto'] },
        'img' => { 'src' => ['http', 'https'] }
      }
    ))
  end

  def translations_params
    params.require(:article).permit(translations: [:locale, :title, :lead, :body, :meta_title, :meta_description])[:translations] || []
  end

  def save_translations(article, translations)
    translations.each do |t|
      article.translations.find_or_initialize_by(locale: t[:locale]).update!(t.slice(
        :title, :lead, :body, :meta_title, :meta_description
      ))
    end
  end

  def serialize_article(article, lang)
    trans = article.translations.find { |t| t.locale == lang } ||
            article.translations.first

    {
      id: article.id,
      slug: article.slug,
      status: article.status.to_s,
      published_at: article.published_at&.iso8601,
      category: article.category&.slice(:id, :key)&.merge(
        name: article.category&.name(lang)
      ),
      title: trans&.title,
      lead: trans&.lead,
      body: trans&.body,
      meta_title: trans&.meta_title,
      meta_description: trans&.meta_description
    }
  end

  def serialize_article_for_edit(article)
    # Собираем ВСЕ переводы в хеш
    translations = {}
    %w[ru kk en].each do |locale|
      tr = article.translations.find { |t| t.locale == locale } ||
           article.translations.find { |t| t.locale == 'ru' } ||
           OpenStruct.new(title: '', lead: '', body: '', meta_title: '', meta_description: '')

      translations[locale.to_sym] = {
        title: tr.title,
        lead: tr.lead,
        body: tr.body,
        meta_title: tr.meta_title,
        meta_description: tr.meta_description
      }
    end

    {
      id: article.id,
      slug: article.slug,
      status: article.status.to_s,
      published_at: article.published_at&.iso8601,
      category_id: article.category_id,
      translations: translations
    }
  end
end
