require 'rails_helper'

describe UserProfile do
  describe 'validations' do
    context 'when username is blank' do
      let(:user_profile) { FactoryGirl.build(:user_profile, username: '') }

      it 'should not be valid' do
        expect(user_profile.valid?).to be false
      end

      it' returns an error message' do
        user_profile.save
        expect(user_profile.errors.count).to eq 1
      end
    end

    context 'when user is absent' do
      let(:user_profile) { FactoryGirl.build(:user_profile, user_id: '') }

      it' should not be valid' do
        expect(user_profile.valid?).to be false
      end

      it 'returns an error message' do
        user_profile.save
        expect(user_profile.errors.count).to eq 2
      end
    end
  end
end
