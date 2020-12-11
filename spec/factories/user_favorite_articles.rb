# == Schema Information
#
# Table name: user_favorite_articles
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :integer
#  user_id    :integer
#
FactoryBot.define do
  factory :user_favorite_article do
    user_id { 1 }
    article_id { 1 }
  end
end
