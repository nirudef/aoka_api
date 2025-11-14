# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate, except: :me
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    users = User.includes(branch: :translations)

    # Поиск по ФИО, email или ИИН
    if params[:query].present?
      q = "%#{params[:query]}%"
      users = users.where("first_name ILIKE ? OR last_name ILIKE ? OR iin ILIKE ? OR email ILIKE ?", q, q, q, q)
    end

    # Фильтр по роли
    if params[:role].present?
      users = users.where("roles @> ?", [params[:role]].to_json)
    end

    # Фильтр по филиалу
    users = users.where(branch_id: params[:branch_id]) if params[:branch_id].present?

    # Пагинация
    users = users.page(params[:page]).per(params[:per_page] || 20)

    render json: {
      users: users.map { |u|
        {
          id: u.id,
          email: u.email,
          first_name: u.first_name,
          last_name: u.last_name,
          middle_name: u.middle_name,
          roles: u.roles,
          branch: u.branch && {
            id: u.branch.id,
            translations: {
              ru: u.branch.translations.find_by(locale: :ru)&.slice(:name, :address, :description)
            }
          }
        }
      },
      meta: {
        current_page: users.current_page,
        total_pages: users.total_pages,
        total_count: users.total_count
      }
    }
    # users = User.includes(branch: :translations)
    #
    # render json: users.map { |u|
    #   {
    #     id: u.id,
    #     email: u.email,
    #     first_name: u.first_name,
    #     last_name: u.last_name,
    #     middle_name: u.middle_name,
    #     roles: u.roles,
    #     branch: u.branch && {
    #       id: u.branch.id,
    #       translations: {
    #         ru: u.branch.translations.find_by(locale: :ru)&.slice(:name, :address, :description)
    #       }
    #     }
    #   }
    # }
  end
  def create
    user = User.new(user_params)

    # Генерация пароля, если не передан
    user.password ||= SecureRandom.alphanumeric(12)

    if user.save
      render json: { message: 'Пользователь создан', password: user.password }, status: :created
    else
      render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def show
    render json: @user.as_json(
      only: [:id, :first_name, :last_name, :middle_name, :iin, :phone, :email,
             :license_number, :license_issued_at, :joined_at, :branch_id, :law_office_id, :address, :password],
      methods: [:roles] # assuming roles stored as array in JSONB
    )
  end

  def update
    if @user.update(user_params)
      render json: { success: true }
    else
      render json: { error: @user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: { success: true }
    else
      render json: { error: 'Не удалось удалить пользователя' }, status: :unprocessable_entity
    end
  end

  def me
    if Current.user.present?
      user = Current.user

      render json: {
        user: {
          id: user.id,
          email: user.email,
          verified: user.verified,
          first_name: user.first_name,
          last_name: user.last_name,
          middle_name: user.middle_name,
          iin: user.iin,
          phone: user.phone,
          license_number: user.license_number,
          license_issued_at: user.license_issued_at,
          joined_at: user.joined_at,
          branch_id: user.branch_id,
          law_office_id: user.law_office_id,
          address: user.address,
          roles: user.roles
        }
      }, status: :ok
    else
      render json: { error: 'Not authenticated' }, status: :unauthorized
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Пользователь не найден' }, status: :not_found
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :middle_name, :iin, :phone, :email, :password,
      :license_number, :license_issued_at, :joined_at, :branch_id, :law_office_id, :address,
      roles: []
    )
  end
end
