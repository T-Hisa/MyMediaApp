# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string(255)      not null
#  isAdmin         :boolean          default(FALSE)
#  name            :string(255)      not null
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'create user' do

    context 'when given correct parameter' do
      let(:user) { create(:correct_user) }
      it 'user model count increment by 1' do
        expect{ user.save }.to change{ User.count }.by(1)
      end
    end

    context 'when given wrong parameter' do
      let(:empty_name_user) { build(:empty_name_user) }
      it 'empty-name causes error' do
        expect(empty_name_user).to be_invalid
      end

      let(:long_name_user) { build(:long_name_user) }
      it 'long-name causes error' do
        expect(long_name_user).to be_invalid
      end

      let(:invalid_email_user) { build(:invalid_email_user) }
      it 'wrong-email causes error' do
        expect(wrong_email_user).to be_invalid
      end

      let(:short_password_user) { build(:short_password_user)}
      it 'short-password causes error' do
        expect(short_password_user).to be_invalid
      end

      let(:not_match_password_user) { build(:not_match_password_user) }
      it 'not-match password causes error' do
        expect(not_match_password_user).to be_invalid
      end
    end
  end
end
