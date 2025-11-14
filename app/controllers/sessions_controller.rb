class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  before_action :set_session, only: %i[ show destroy ]

  def index
    render json: Current.user.sessions.order(created_at: :desc)
  end

  def show
    render json: @session
  end

  # def create
  #   p params
  #   if user = User.authenticate_by(email: params[:email], password: params[:password])
  #     p user
  #     @session = user.sessions.create!
  #     response.set_header "X-Session-Token", @session.signed_id
  #
  #     render json: @session, status: :created
  #   else
  #     render json: { error: "That email or password is incorrect" }, status: :unauthorized
  #   end
  # end
  def create
    if user = User.authenticate_by(email: params[:email], password: params[:password])
      @session = user.sessions.create!

      render json: {
        token: @session.signed_id,
        user: {
          id: user.id,
          email: user.email,
          verified: user.verified
        }
      }, status: :created
    else
      render json: { error: "That email or password is incorrect" }, status: :unauthorized
    end
  end

  def destroy
    @session.destroy
  end

  def destroy_current
    if Current.session
      Current.session.destroy
      head :no_content
    else
      render json: { error: "Session not found" }, status: :not_found
    end
  end

  private
    def set_session
      @session = Current.user.sessions.find(params[:id])
    end
end
