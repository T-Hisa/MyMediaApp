# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  email            :string(255)      not null
#  isAdmin          :boolean          default(FALSE)
#  name             :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  favorite_news_id :bigint
#
# Indexes
#
#  index_users_on_favorite_news_id  (favorite_news_id)
#
class User < ApplicationRecord
  has_many :favorite_news, class_name: "News",
            foreign_key: "favoorite_news_id"
end
