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
class UserFavoriteArticle < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :article, class_name: "Article"
end
