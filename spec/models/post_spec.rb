require 'rails_helper'

describe Post do
  describe 'validations' do
    context 'when post body is blank' do
      let(:post) { FactoryGirl.build(:post, body: '') }

      it 'should not be valid' do
        expect(post.valid?).to be false
      end

      it 'returns an error message' do
        post.save
        expect(post.errors.count).to eq 1
      end
    end

    context 'when user id is absent' do
      let(:post) { FactoryGirl.build(:post, user: nil) }

      it 'should not be valid' do
        expect(post.valid?).to be false
      end

      it 'returns an error message' do
        post.save
        expect(post.errors.count).to eq 2
      end
    end

    context 'when post body is too long' do
      body = 'a'*161
      let(:post) { FactoryGirl.build(:post, body: body) }

      it 'should not be valid' do
        expect(post.valid?).to be false
      end

      it 'returns an error message' do
        post.save
        expect(post.errors.count).to eq 1
      end
    end
  end
end
