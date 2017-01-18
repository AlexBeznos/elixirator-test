require 'rails_helper'

RSpec.describe Product, type: :model do
  context '.updated_during_last_week' do
    it 'returns products that were updated during last week except today' do
      create(:product, title: 'unexpected', updated_at: 7.days.ago)
      create(:product, title: 'unexpected', updated_at: Time.now)
      create(:product, title: 'expected-3', updated_at: 6.days.ago)
      create(:product, title: 'expected-2', updated_at: 4.days.ago)
      create(:product, title: 'expected-1', updated_at: 2.days.ago)

      result = Product.updated_during_last_week

      expect(result.count).to eq(3)
      expect(result.map(&:title))
        .to match_array(%w(expected-1 expected-2 expected-3))
    end
  end

  context '.updated_by_employee' do
    it 'returns products that were updated by employee' do
      admin = create(:admin)
      manager = create(:manager)
      employee_1 = create(:employee)
      employee_2 = create(:employee)
      create(:product, title: 'unexpected', updated_by: admin.id)
      create(:product, title: 'unexpected', updated_by: manager.id)
      create(:product, title: 'expected', updated_by: employee_1.id)
      create(:product, title: 'expected', updated_by: employee_2.id)
      create(:product, title: 'expected', updated_by: employee_2.id)

      result = Product.updated_by_employee

      expect(result.count).to eq(3)
      expect(result.map(&:title))
        .to match_array(%w(expected expected expected))
    end
  end

  context '.last_week_employee_updated' do
    it 'returns products that was updated by employees during last week except today ordered by last update' do
      admin = create(:admin)
      employee = create(:employee)
      manager = create(:manager)
      create(:product, title: 'unexpected', updated_by: admin.id, updated_at: 2.days.ago)
      create(:product, title: 'unexpected', updated_by: manager.id, updated_at: 2.days.ago)
      create(:product, title: 'unexpected', updated_by: employee.id, updated_at: 7.days.ago)
      create(:product, title: 'unexpected', updated_by: employee.id, updated_at: Time.now)
      create(:product, title: 'expected-3', updated_by: employee.id, updated_at: 4.days.ago)
      create(:product, title: 'expected-2', updated_by: employee.id, updated_at: 3.days.ago)
      create(:product, title: 'expected-1', updated_by: employee.id, updated_at: 2.days.ago)

      result = Product.last_week_employee_updated

      expect(result.count).to eq(3)
      expect(result.map(&:title)).to eq %w(expected-1 expected-2 expected-3)
    end
  end
end