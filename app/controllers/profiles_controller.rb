# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  # before_action :authenticate! # используем auth-zero или свой метод

  def show
    render json: {
      id: Current.user.id,
      email: Current.user.email,
      verified: Current.user.verified
    }
  end
end
