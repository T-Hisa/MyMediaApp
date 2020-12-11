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

  has_many :articles
  has_many :user_favorite_articles
  has_many :favorite_articles, through: :user_favorite_articles, source: :article
  validates :name, presence: true, length: { maximum: 16 }
  validates :email,
    length: { maximum: 100 },
    uniqueness: { case_sensitive: true },
    format: {
      with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
      message: 'を正しい形式で入力してください'
    }
  validates :password, length: { minimum: 6 }

  private
    def email_downcase
      self.email.downcase!
    end
end
