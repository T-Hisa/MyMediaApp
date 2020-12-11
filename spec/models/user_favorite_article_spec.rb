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
require 'rails_helper'

RSpec.describe UserFavoriteArticle, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
