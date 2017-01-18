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

    scenario 'should not see filter' do
      expect(page).not_to have_selector('.products .order-filter')
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

    scenario 'should not see filter' do
      expect(page).not_to have_selector('.products .order-filter')
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

    scenario 'should see edit button' do
      expect(page).to have_selector('.product a.edit')
    end

    scenario 'should see archive button' do
      expect(page).to have_selector('.product a.archive')
    end

    scenario 'should not see filter' do
      expect(page).not_to have_selector('.products .order-filter')
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

    scenario 'should see edit button' do
      expect(page).to have_selector('.product a.edit')
    end

    scenario 'should see archive button' do
      expect(page).to have_selector('.product a.archive')
    end

    scenario 'should see filter' do
      expect(page).to have_selector('.products .order-filter')
    end
  end

  context 'able to see product with sale' do
    scenario 'should see sale label' do
      create(:product, sale: 0.40, price: 10)

      visit root_path

      expect(page).to have_selector('.product', count: 1)
      expect(page).to have_content('With sale')
      expect(page).to have_content('$20.00')
      expect(page).to have_selector('.product .sale', count: 1)
    end
  end

  context 'able to see product without sale' do
    scenario 'should not see sale label' do
      create(:product, sale: 0.0, price: 10)

      visit root_path

      expect(page).to have_selector('.product', count: 1)
      expect(page).not_to have_content('With sale')
      expect(page).to have_content('$10.00')
      expect(page).not_to have_selector('.product .sale', count: 1)
    end
  end
end
