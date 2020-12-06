# == Schema Information
#
# Table name: users
#
#  id                   :bigint           not null, primary key
#  email                :string(255)      not null
#  favorite_article_ids :integer
#  isAdmin              :boolean          default(FALSE)
#  name                 :string(255)      not null
#  password_digest      :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class User < ApplicationRecord

end