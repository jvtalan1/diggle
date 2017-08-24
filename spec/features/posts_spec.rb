require 'rails_helper'

describe 'Posts Page Navigation', type: :feature do
  describe 'Posts Creation' do
    context 'when user input is valid' do
      let!(:user) { FactoryGirl.create(:user, username: 'usertest', email: 'user@test.com', password: 'password') }

      before do
        visit '/users/sign_in'
        fill_in 'Email', with: 'user@test.com'
        fill_in 'Password', with: 'password'
        click_button 'Log in'
        fill_in 'post_body', with: 'Hello diggle!'
        click_button 'Share'
      end

      it 'creates new post' do
        expect(page).to have_content 'just now'
        expect(page).to have_content 'Hello diggle!'
      end
    end
  end
end
