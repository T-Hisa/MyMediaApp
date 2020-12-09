# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  isDeleted  :boolean          default(FALSE)
#  isDraft    :boolean          default(FALSE)
#  summary    :string(255)
#  title      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 10 }
  validates :summary, length: { maximum: 50 }
  validates :content, presence: true
  has_one_attached :image
end
