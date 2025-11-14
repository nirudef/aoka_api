# frozen_string_literal: true

class Api::V1::CategoriesController < ApplicationController
  skip_before_action :authenticate
  # before_action :require_admin, only: [:create, :update, :destroy]

  # GET /api/v1/categories?lang=ru
  def index
    lang = params[:lang]&.in?(%w[ru kk en]) || 'ru'

    categories = Category.includes(:translations)
                         .map do |c|
      {
        id: c.id,
        key: c.key,
        name: c.name(lang),
        position: c.position
      }
    end

    render json: { categories: categories }
  end

  def show
    @category = Category.find(params[:id])
    # lang = params[:lang]&.in?(%w[ru kk en]) || 'ru'
    render json: serialize_category(@category)
  end

  # POST /api/v1/categories
  def create
    category = Category.new(category_params)

    if category.save
      save_translations(category, translations_params)
      render json: {
        id: category.id,
        key: category.key,
        name: category.name('ru')
      }, status: :created
    else
      render json: { error: category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/categories/:id
  def update
    category = Category.find(params[:id])

    if category.update(category_params)
      save_translations(category, translations_params)
      render json: { success: true }
    else
      render json: { error: category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/categories/:id
  def destroy
    category = Category.find(params[:id])
    category.destroy!
    head :no_content
  end

  private

  def category_params
    params.require(:category).permit(:key, :position)
  end

  def translations_params
    params.require(:category).permit(translations: [:locale, :name])[:translations] || []
  end

  def save_translations(category, translations)
    translations.each do |t|
      category.translations.find_or_initialize_by(locale: t[:locale])
              .update!(name: t[:name])
    end
  end

  def serialize_category(category)
    translations = {}
    %w[ru kk en].each do |locale|
      trans = category.translations.find { |t| t.locale == locale }
      translations[locale.to_sym] = trans ? { name: trans.name } : { name: '' }
    end

    {
      id: category.id,
      key: category.key,
      position: category.position,
      name: category.name, # Название на текущем языке (для удобства)
      translations: translations,
      articles_count: category.articles.published.count
    }

    # # Собираем ВСЕ переводы в хеш
    # translations = {}
    # %w[ru kk en].each do |locale|
    #   tr = category.translations.find { |t| t.locale == locale } ||
    #        category.translations.find { |t| t.locale == 'ru' } ||
    #        OpenStruct.new(title: '', lead: '', body: '', meta_title: '', meta_description: '')
    #
    #   translations[locale.to_sym] = {
    #     title: tr.title,
    #     lead: tr.lead,
    #     body: tr.body,
    #     meta_title: tr.meta_title,
    #     meta_description: tr.meta_description
    #   }
    # end
    #
    # {
    #   id: category.id,
    #   slug: article.slug,
    #   status: article.status.to_s,
    #   published_at: article.published_at&.iso8601,
    #   category_id: article.category_id,
    #   translations: translations
    # }
  end
end
