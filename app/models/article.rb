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
#
class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 10 }
  validates :summary, presence: true, length: { maximum: 50 }
  validates :content, presence: true
end
