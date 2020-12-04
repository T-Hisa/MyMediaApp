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
require 'rails_helper'

RSpec.describe News, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
