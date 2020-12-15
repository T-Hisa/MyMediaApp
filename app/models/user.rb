# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string(255)      not null
#  isAdmin         :boolean          default(FALSE)
#  name            :string(255)      not null
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password
  before_save :email_downcase
  attr_accessor :remember_token

  has_many :articles
  has_many :user_favorite_articles
  has_many :favorite_articles, through: :user_favorite_articles, source: :article
  validates :name, presence: true, length: { maximum: 16 }
  invalid_message = I18n.t('shared.invalid_email')
  validates :email,
            length: { maximum: 100 },
            uniqueness: { case_sensitive: true },
            format: {
              with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
              message: invalid_message
            }
  validates :password, length: { minimum: 6 }


  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(token)
    remember_digest.present? ? BCrypt::Password.new(remember_digest).is_password?(token) : false
  end

  private
    def email_downcase
      email.downcase!
    end
end
