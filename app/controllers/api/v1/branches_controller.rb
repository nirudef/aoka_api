class Api::V1::BranchesController < ApplicationController
  skip_before_action :authenticate
  def index
    # I18n.locale = params[:lang] || I18n.default_locale
    # branches = Branch.with_translations(I18n.locale)
    # render json: branches.map { |b|
    #   {
    #     id: b.id,
    #     name: b.name,
    #     address: b.address,
    #     description: b.description,
    #     phone: b.phone,
    #     email: b.email,
    #     latitude: b.latitude,
    #     longitude: b.longitude
    #   }
    # }
    # branches = Branch.all.includes(:translations)
    #
    # render json: branches.map { |b|
    #   {
    #     id: b.id,
    #     phone: b.phone,
    #     email: b.email,
    #     latitude: b.latitude,
    #     longitude: b.longitude,
    #     translations: {
    #       ru: b.translations.find { |t| t.locale == 'ru' }&.slice(:name, :address, :description) || {},
    #       kz: b.translations.find { |t| t.locale == 'kz' }&.slice(:name, :address, :description) || {},
    #       en: b.translations.find { |t| t.locale == 'en' }&.slice(:name, :address, :description) || {}
    #     }
    #   }
    # }
    branches = Branch.includes(:translations)

    render json: branches.map { |b|
      translations = b.translations.each_with_object({}) do |tr, h|
        h[tr.locale.to_sym] = {
          name: tr.name,
          address: tr.address,
          description: tr.description
        }
      end

      {
        id: b.id,
        phone: b.phone,
        email: b.email,
        latitude: b.latitude,
        longitude: b.longitude,
        translations: {
          ru: translations[:ru] || { name: '', address: '', description: '' },
          kk: translations[:kk] || { name: '', address: '', description: '' },
          en: translations[:en] || { name: '', address: '', description: '' }
        }
      }
    }
  end

  def create
    branch = Branch.new(branch_params.except(:translations))
    if branch.save
      branch_params[:translations].each do |locale, attrs|
        branch.translations.create!(attrs.merge(locale: locale.to_s))
      end
      render json: branch_with_translations(branch)
    else
      render json: { error: branch.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # def update
  #   branch = Branch.find(params[:id])
  #
  #   # Обновляем общие поля
  #   branch.assign_attributes(branch_params.except(:translations))
  #
  #   p branch_params[:translations]
  #   # Обновляем переводы сразу для всех языков
  #   if branch_params[:translations]
  #     branch_params[:translations].each do |locale, data|
  #       translation = branch.translations.find_or_initialize_by(locale: locale)
  #       p data
  #       # translation.assign_attributes(data)
  #       translation.assign_attributes(params_for_translation.to_unsafe_h.slice('name','address','description'))
  #       # translation.assign_attributes(data.permit(:name, :address, :description))
  #       # p translation
  #       translation.save!
  #     end
  #   end
  #
  #   if branch.save
  #     render json: { success: true, branch: branch.reload.as_json(include: :translations) }
  #   else
  #     render json: { success: false, errors: branch.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end



  def update
    branch = Branch.find(params[:id])

    Branch.transaction do
      # Обновляем общие поля (без translations)
      branch.update!(branch_params.except(:translations))

      # Обновляем переводы через globalize API
      if branch_params[:translations].present?
        branch_params[:translations].each do |locale, translation_data|
          I18n.with_locale(locale.to_s) do
            branch.name = translation_data[:name]
            branch.address = translation_data[:address]
            branch.description = translation_data[:description]
            branch.save!
          end
        end
      end

      render json: branch_with_translations(branch.reload)
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { success: false, errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def destroy
    branch = Branch.find(params[:id])
    branch.destroy
    head :no_content
  end

  private

  def branch_params
    params.require(:branch).permit(
      :phone, :email, :latitude, :longitude,
      translations: {
        ru: [:name, :address, :description],
        kk: [:name, :address, :description],
        en: [:name, :address, :description]
      }
    )
  end

  def branch_with_translations(branch)
    translations = branch.translations.each_with_object({}) do |tr, h|
      h[tr.locale.to_sym] = { name: tr.name, address: tr.address, description: tr.description }
    end
    {
      id: branch.id,
      phone: branch.phone,
      email: branch.email,
      latitude: branch.latitude,
      longitude: branch.longitude,
      translations: {
        ru: translations[:ru] || { name: '', address: '', description: '' },
        kk: translations[:kk] || { name: '', address: '', description: '' },
        en: translations[:en] || { name: '', address: '', description: '' }
      }
    }
  end
end
