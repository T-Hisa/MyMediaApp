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
FactoryBot.define do
  factory :correct_article, class: Article do
    title { "correct" }
    content { "correct" }
    summary { "" }
    association :user,
      factory: :correct_user

    factory :long_title_article do
      title { "x" * 11 } 
    end

    factory :empty_title_article, class: Article do
      title { "" }
    end

    factory :empty_content_article, class: Article do
      content { "" }
    end

    factory :draft_article do
      isDraft { true }
    end
  end
end
