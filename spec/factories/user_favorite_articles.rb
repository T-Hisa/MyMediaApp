# == Schema Information
#
# Table name: user_favorite_articles
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_favorite_articles_on_article_id  (article_id)
#  index_user_favorite_articles_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_favorite_article do
    user_id { nil }
    article_id { nil }
  end
end
