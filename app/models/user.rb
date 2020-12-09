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
  has_many :favorite_articles, class_name: :Article
  validates :name, presence: true, length: { maximum: 16 }
  validates :email,
    length: { maximum: 100 },
    uniqueness: { case_sensitive: true },
    format: {
      with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
      message: 'を正しい形式で入力してください'
    }

  private
    def email_downcase
      self.email.downcase!
    end
end
