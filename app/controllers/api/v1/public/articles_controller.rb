# frozen_string_literal: true

class Api::V1::Public::ArticlesController < ApplicationController
  skip_before_action :authenticate

  def index
    # Определяем язык
    lang = params[:lang]&.in?(%w[ru kk en]) ? params[:lang] : 'ru'

    # Отладочный вывод (если нужен)
    Rails.logger.info "Articles requested with lang: #{lang}"

    # Загружаем статьи с установленной локалью
    articles = Article.published
                      .includes(:category, :translations)
                      .page(params[:page])
                      .per(10)

    render json: {
      articles: articles.map { |a| serialize_article(a, lang) },
      meta: {
        current_page: articles.current_page,
        total_pages: articles.total_pages,
        total_count: articles.total_count
      }
    }
  end

  def show
    @article = Article.friendly.find(params[:id])
    lang = params[:lang]&.in?(%w[ru kk en]) ? params[:lang] : 'ru'
    render json: serialize_article(@article, lang)
  end

  private

  def serialize_article(article, lang)
    # Находим перевод статьи на нужный язык (или fallback на ru)
    trans = article.translations.find { |t| t.locale == lang } ||
            article.translations.find { |t| t.locale == 'ru' }

    # Получаем название категории на нужном языке
    category_trans = article.category&.translations&.find { |ct| ct.locale == lang } ||
                     article.category&.translations&.find { |ct| ct.locale == 'ru' }

    {
      id: article.id,
      slug: article.slug,
      status: article.status,
      published_at: article.published_at&.iso8601,
      category: article.category ? {
        id: article.category.id,
        key: article.category.key,
        name: category_trans&.name
      } : nil,
      title: trans&.title,
      lead: trans&.lead,
      body: trans&.body,
      meta_title: trans&.meta_title,
      meta_description: trans&.meta_description
    }
  end

end
