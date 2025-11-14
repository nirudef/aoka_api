class User < ApplicationRecord
  has_secure_password

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end

  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end


  has_many :sessions, dependent: :destroy

  # optional: true - явно указываем, что связи необязательные
  belongs_to :branch, optional: true
  belongs_to :law_office, optional: true

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :iin, uniqueness: true, allow_nil: true, length: { is: 12 }
  validates :phone, uniqueness: true, allow_nil: true

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 12 }

  normalizes :email, with: -> { _1.strip.downcase }

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end

  def branch_head?
    roles.include?('branch_head')
  end

  def admin?
    roles.include?('admin')
  end
end
