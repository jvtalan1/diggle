require 'rails_helper'

describe 'Users Page Navigation', type: :feature do
  describe 'User Registration' do
    before do
      visit 'users/sign_up'
    end

    context 'when the form is valid' do
      before do
        fill_in 'user_username', with: 'usertest'
        fill_in 'user_email', with: 'user@test.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button 'Sign up'
      end

      it "redirects user to update profile page" do
        expect(page).to have_content 'Edit your profile'
      end
    end

    context 'when the form is invalid' do
      context 'and the form is blank' do
        before do
          click_button 'Sign up'
        end

        it 'returns an error page' do
          within('div.user_username') do
            expect(page).to have_content "can't be blank"
          end
          within('div.user_email') do
            expect(page).to have_content "can't be blank"
          end
          within('div.user_password') do
            expect(page).to have_content "can't be blank"
          end
        end
      end

      context 'and username is already taken' do
        let!(:user) { FactoryGirl.create(:user, username: 'usertest', email: 'user@test.com', password: 'password') }
        
        before do
          fill_in 'user_username', with: 'usertest'
          fill_in 'user_email', with: 'user2@test.com'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button 'Sign up'
        end

        it 'returns an error page' do
          within('div.user_username') do
            expect(page).to have_content 'has already been taken'
          end
        end

      end
      
      context 'and email supplied is not a valid email format' do
        before do
          fill_in 'user_username', with: 'testuser'
          fill_in 'user_email', with: 'user'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button 'Sign up'
        end

        it 'returns an error page' do
          within('div.user_email') do
            expect(page).to have_content 'is invalid'
          end
        end
      end
      
      context 'and email is already taken' do
        let!(:user) { FactoryGirl.create(:user, username: 'usertest', email: 'user@test.com', password: 'password') }

        before do
          fill_in 'user_username', with: 'usertest2'
          fill_in 'user_email', with: 'user@test.com'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button 'Sign up'
        end

        it 'returns an error page' do
          within('div.user_email') do
            expect(page).to have_content 'has already been taken'
          end
        end
      end

      context 'and password does not match password confirmation' do
        before do
          fill_in 'user_username', with: 'usertest'
          fill_in 'user_email', with: 'user@test.com'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'passwurd'
          click_button 'Sign up'
        end

        it 'returns an error page' do
          within('div.user_password_confirmation') do
            expect(page).to have_content "doesn't match Password"
          end
        end
      end
    end
  end
end
