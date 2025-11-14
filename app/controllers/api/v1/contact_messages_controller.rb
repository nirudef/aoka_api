# app/controllers/api/v1/contact_messages_controller.rb
class Api::V1::ContactMessagesController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def create
    name = params[:name]
    email = params[:email]
    message = params[:message]
    lang = params[:lang]

    if name.blank? || email.blank? || message.blank?
      render json: { error: 'Missing required fields' }, status: :unprocessable_entity
      return
    end

    ContactMailer.with(name:, email:, message:, lang:).notify_admin.deliver_later
    render json: { success: true }
  end
end
