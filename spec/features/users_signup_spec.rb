require 'rails_helper'

describe 'Users Signup', type: :feature do
  before do
    visit 'users/sign_up'
  end

  context 'when the form is valid' do
    before do
      fill_in 'user_email', with: 'user@test.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Sign up'
    end

    it 'redirects user back to login page' do
      expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account'
    end

    it "sends a confirmation email to user's email" do
      email = ActionMailer::Base.deliveries.last
      expect(email).to have_content 'Thank you for signing up to Diggle'
    end

    it 'redirects user to edit profile page after confirming email' do
      email = ActionMailer::Base.deliveries.last
      link = email.body.raw_source.match(/href="(?<url>.+?)">/)[:url]
      visit link
      expect(page).to have_content 'Edit your profile'
    end

    it 'redirects user to home page after updating profile' do
      email = ActionMailer::Base.deliveries.last
      link = email.body.raw_source.match(/href="(?<url>.+?)">/)[:url]
      visit link
      fill_in 'Full name', with: 'User Test'
      fill_in 'Username', with: 'testuser'
      fill_in 'Phone number', with: '123456789'
      fill_in 'Location', with: 'U.S.A'
      click_button 'Update Profile'
      expect(page).to have_content 'Notifications'
      expect(page).to have_content 'Who to follow'
    end
  end

  context 'when the form is invalid' do
    context 'and the form is blank' do
      before do
        click_button 'Sign up'
      end

      it 'returns an error page' do
        within('div.user_email') do
          expect(page).to have_content "can't be blank"
        end
        within('div.user_password') do
          expect(page).to have_content "can't be blank"
        end
      end
    end
    
    context 'and email supplied is not a valid email format' do
      before do
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
      let!(:user) { FactoryGirl.create(:user, email: 'user@test.com', password: 'password') }

      before do
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

    context 'and username is blank' do
      before do
        fill_in 'user_email', with: 'user@test.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button 'Sign up'
        email = ActionMailer::Base.deliveries.last
        link = email.body.raw_source.match(/href="(?<url>.+?)">/)[:url]
        visit link
        fill_in 'Full name', with: 'User Test'
        fill_in 'Username', with: ''
        fill_in 'Phone number', with: '123456789'
        fill_in 'Location', with: 'U.S.A'
        click_button 'Update Profile'
      end

      it 'returns an error page' do
        within('div.user_user_profile_username') do
          expect(page).to have_content "can't be blank"
        end
      end
    end

    context 'and username is already taken' do
      let!(:user) { FactoryGirl.create(:user, email: 'user@test.com', password: 'password', user_profile_attributes: { username: 'testuser' }) }

      before do
        fill_in 'user_email', with: 'user2@test.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button 'Sign up'
        email = ActionMailer::Base.deliveries.last
        link = email.body.raw_source.match(/href="(?<url>.+?)">/)[:url]
        visit link
        fill_in 'Full name', with: 'User Test'
        fill_in 'Username', with: 'testuser'
        fill_in 'Phone number', with: '123456789'
        fill_in 'Location', with: 'U.S.A'
        click_button 'Update Profile'
      end

      it 'returns an error page' do
        within('div.user_user_profile_username') do
          expect(page).to have_content 'has already been taken'
        end
      end
    end
  end
end
