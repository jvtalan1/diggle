require 'rails_helper'

describe User do
  describe 'validations' do
    context 'when email is blank' do
      let(:user) { FactoryGirl.build(:user, email: '') }

      it 'should not be valid' do
        expect(user.valid?).to be false
      end

      it 'returns an error message' do
        user.save
        expect(user.errors.count).to eq 1
      end
    end

    context 'when password is blank' do
      let(:user) { FactoryGirl.build(:user, password: '') }

      it 'should not be valid' do
        expect(user.valid?).to be false
      end

      it 'returns an error message' do
        user.save
        expect(user.errors.count).to eq 1
      end
    end

    context 'when password does not meet length criteria' do
      let(:user) { FactoryGirl.build(:user, password: '1234') }

      it 'should not be valid' do
        expect(user.valid?).to be false
      end

      it 'returns an error message' do
        user.save
        expect(user.errors.count).to eq 1
      end
    end

    context 'when email is already taken' do
      let!(:user) { FactoryGirl.build(:user) }
      let(:user2) { FactoryGirl.build(:user, email: 'test@user.com') }

      it 'should not be valid' do
        user.skip_confirmation!
        user.save!
        expect(user2.valid?).to be false
      end

      it 'returns an error message' do
        user.skip_confirmation!
        user.save!
        user2.save
        expect(user2.errors.count).to eq 1
      end
    end

    context 'when email is not a valid format' do
      let(:user) { FactoryGirl.build(:user, email: 'test.com') }

      it 'should not be valid' do
        expect(user.valid?).to be false
      end

      it 'returns an error message' do
        user.save
        expect(user.errors.count).to eq 1
      end
    end
  end
end
