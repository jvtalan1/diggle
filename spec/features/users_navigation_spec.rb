require 'rails_helper'

describe 'Users Page Navigation', type: :feature do
  describe 'User Registration' do
    before do
      visit 'users/sign_up'
    end

    context 'when the form is valid' do
      before do
        fill_in 'Email', with: 'user@test.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Sign up'
      end

      it "successfully registers the user" do
        expect(page).to have_content 'Welcome user@test.com'
      end
    end

    context 'when the form is invalid' do
      context 'and the form is blank' do
        before do
          click_button 'Sign up'
        end

        it 'returns an error page' do
          expect(page).to have_content "Email can't be blank"
          expect(page).to have_content "Password can't be blank"
        end
      end
      
      context 'and email supplied is not a valid email format' do
        before do
          fill_in 'Email', with: 'user'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'Sign up'
        end

        it 'returns an error page' do
          expect(page).to have_content 'Email is invalid'
        end
      end
      
      context 'and email is already taken' do
        let!(:user) { FactoryGirl.create(:user, email: 'user@test.com', password: 'password') }

        before do
          fill_in 'Email', with: 'user@test.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'Sign up'
        end

        it 'returns an error page' do
          expect(page).to have_content 'Email has already been taken'
        end
      end

      context 'and password does not match password confirmation' do
        before do
          fill_in 'Email', with: 'user@test.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'passwurd'
          click_button 'Sign up'
        end

        it 'returns an error page' do
          expect(page).to have_content "Password confirmation doesn't match Password"
        end
      end
    end
  end
end
