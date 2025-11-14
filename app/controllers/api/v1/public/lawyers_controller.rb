# app/controllers/api/v1/public/lawyers_controller.rb
class Api::V1::Public::LawyersController < ApplicationController
  skip_before_action :authenticate
  def index
    users = User.includes(law_office: :translations, branch: :translations)
                .where("roles @> ?", ['advocate'].to_json)

    p users
    # Поиск по ФИО, email или ИИН
    if params[:query].present?
      q = "%#{params[:query]}%"
      users = users.where("first_name ILIKE ? OR last_name ILIKE ? OR iin ILIKE ? OR email ILIKE ?", q, q, q, q)
    end

    # Фильтр по адвокатской конторе
    users = users.where(law_office_id: params[:law_office_id]) if params[:law_office_id].present?

    # Фильтр по филиалу
    users = users.where(branch_id: params[:branch_id]) if params[:branch_id].present?

    # Пагинация
    users = users.page(params[:page]).per(params[:per_page] || 20)

    p users

    render json: {
      users: users.map { |u|
        {
          id: u.id,
          first_name: u.first_name,
          last_name: u.last_name,
          middle_name: u.middle_name,
          email: u.email,
          roles: u.roles,
          law_office: u.law_office && {
            id: u.law_office.id,
            translations: u.law_office.translations.each_with_object({}) do |t, h|
              h[t.locale] = { name: t.name }
            end
          },
          branch: u.branch && {
            id: u.branch.id,
            translations: u.branch.translations.each_with_object({}) do |t, h|
              h[t.locale] = { name: t.name }
            end
          }
        }
      },
      meta: {
        current_page: users.current_page,
        total_pages: users.total_pages,
        total_count: users.total_count
      }
    }
  end
end
