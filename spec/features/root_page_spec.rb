require 'rails_helper'

RSpec.feature "user came to root page", type: :feature do
  context 'as not authenticated user' do
    before do
      create_list(:product, 3)
      visit root_path
    end

    scenario 'see products list' do
      expect(page).to have_selector('.product', count: 3)
    end

    scenario 'should not see edit button' do
      expect(page).not_to have_selector('.product a.edit')
    end

    scenario 'should not see archive button' do
      expect(page).not_to have_selector('.product a.archive')
    end
  end

  context 'as an employee user' do
    before do
      create_list(:product, 3)
      login(create(:employee))
      visit root_path
    end

    scenario 'see products list' do
      expect(page).to have_selector('.product', count: 3)
    end

    scenario 'should see edit button' do
      expect(page).to have_selector('.product a.edit')
    end

    scenario 'should not see archive button' do
      expect(page).not_to have_selector('.product a.archive')
    end
  end

  context 'as an manager user' do
    before do
      create_list(:product, 3)
      login(create(:manager))
      visit root_path
    end

    scenario 'see products list' do
      expect(page).to have_selector('.product', count: 3)
    end

    scenario 'should not see edit button' do
      expect(page).to have_selector('.product a.edit')
    end

    scenario 'should not see archive button' do
      expect(page).to have_selector('.product a.archive')
    end
  end

  context 'as an admin user' do
    before do
      create_list(:product, 3)
      login(create(:admin))
      visit root_path
    end

    scenario 'see products list' do
      expect(page).to have_selector('.product', count: 3)
    end

    scenario 'should not see edit button' do
      expect(page).to have_selector('.product a.edit')
    end

    scenario 'should not see archive button' do
      expect(page).to have_selector('.product a.archive')
    end
  end
end
