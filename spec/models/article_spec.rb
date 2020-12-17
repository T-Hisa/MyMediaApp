# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  isDraft    :boolean          default(FALSE)
#  summary    :string(255)
#  title      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_articles_on_title    (title)
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Article, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  describe "create article model" do
    context 'when correct parameter was given' do
      # before do
      #   @correct_article = build(:correct_article)
      # end
      let(:article) { create(:correct_article) }
      it 'article model count increments by 1' do
        expect{ article.save }.to change{ Article.count }.by(1)
      end
    end

    context 'when wrong parameter was given' do
      let(:long_title_article) { build(:long_title_article) }
      it 'long-title causes error' do
        expect(long_title_article).to be_invalid
      end

      let(:empty_title_article) { build(:empty_title_article) }
      it 'empty-title causes error' do
        expect(empty_title_article).to be_invalid
      end

      let(:empty_content_article) { build(:empty_content_article) }
      it 'empty-content causes error' do
        expect(empty_content_article).to be_invalid
      end
    end

  end


end
