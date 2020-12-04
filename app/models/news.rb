# == Schema Information
#
# Table name: news
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  isDeleted  :boolean          default(FALSE)
#  isDraft    :boolean          default(FALSE)
#  title      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class News < ApplicationRecord
end