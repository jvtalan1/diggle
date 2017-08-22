require 'rails_helper'

describe 'Posts Page Navigation', type: :feature do
  describe 'Posts Creation' do
    context 'when user input is valid' do
      let!(:user) { FactoryGirl.create(:user, email: 'user@test.com', password: 'password') }

      before do
        visit '/users/sign_in'
        fill_in 'Email', with: 'user@test.com'
        fill_in 'Password', with: 'password'
        click_button 'Log in'
        click_link 'Create new post'
        fill_in 'post_body', with: 'Hello diggle!'
        click_button 'Create Post'
      end

      it 'creates new post' do
        expect(page).to have_content 'Post was successfully created'
      end
    end
  end
end
