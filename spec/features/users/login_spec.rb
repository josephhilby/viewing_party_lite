require 'rails_helper'

RSpec.describe "The Login Page", type: :feature do
  describe "When I visit the login path" do
    before(:each) do
      @user = create(:user)
      visit login_path
    end

    it 'then I see a form with email and password' do
      within '#login_form' do
        expect(page).to have_content("Email")
        expect(page).to have_content("Password")
        expect(page).to have_button("Log In")
      end
    end

    context 'given valid credentials' do
      it 'can log in' do
        within '#login_form' do
          fill_in :email, with: @user.email
          fill_in :password, with: @user.password

          click_button 'Log In'
        end

        expect(page).to have_current_path(user_path(@user))
      end
    end

    context 'given non-valid credentials' do
      it 'returns an error' do
        within '#login_form' do
          fill_in :email, with: @user.email
          fill_in :password, with: "incorrect password"

          click_button 'Log In'
        end

        expect(page).to have_current_path(login_path)
        expect(page).to have_content("Unknown username or password")
      end

      it 'returns an error' do
        within '#login_form' do
          fill_in :email, with: "incorrect email"
          fill_in :password, with: @user.password

          click_button 'Log In'
        end

        expect(page).to have_current_path(login_path)
        expect(page).to have_content("Unknown username or password")
      end
    end
  end
end