# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'The Welcome Page', type: :feature do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:user_3) { create(:user) }

  before do
    visit root_path
  end

  describe 'When I visit the welcome page' do
    it 'I see the title of the application' do
      expect(page).to have_content('Viewing Party')
    end

    context 'when I am not logged in' do
      it 'I see a button to "Create a New User"' do
        within '#new_user_button' do
          expect(page).to_not have_button('Log Out')
          click_button 'Create a New User'

          expect(page).to have_current_path(register_path, ignore_query: true)
        end
      end

      it 'I see a button to "Log In"' do
        within '#new_user_button' do
          expect(page).to_not have_button('Log Out')
          click_button 'Log In'

          expect(page).to have_current_path(login_path, ignore_query: true)
        end
      end
    end

    context 'when I am logged in' do
      it 'I see a button to "Log Out"' do
        visit login_path
        fill_in :email, with: user_1.email
        fill_in :password, with: user_1.password
        click_button 'Log In'

        visit root_path
        within '#new_user_button' do

          expect(page).to_not have_button('Log In')
          expect(page).to_not have_button('Create a New User')

          click_button 'Log Out'

          expect(page).to have_current_path(root_path, ignore_query: true)
        end
        expect(page).to have_button('Log In')
        expect(page).to have_button('Create a New User')
      end
    end

    it 'I see a list of existing users which links to the users dashboard' do
      within '#existing_users' do
        expect(page).to have_content(user_1.email)
        expect(page).to have_content(user_2.email)
        expect(page).to have_content(user_3.email)

        click_link user_1.email
      end

      expect(page).to have_current_path(user_path(user_1), ignore_query: true)
    end

    it 'I see a link to go back to the landing page' do
      click_link 'Home'

      expect(page).to have_current_path(root_path, ignore_query: true)
    end
  end
end
