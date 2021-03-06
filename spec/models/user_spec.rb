require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'scope' do
    context '.avarage_managment_age' do
      it 'returns avarage age of users with management role' do
        create(:admin, age: 18)
        create(:employee, age: 20)
        create(:manager, age: 35)
        create(:manager, age: 45)
        create(:manager, age: 55)

        result = User.avarage_managment_age

        expect(result).to be_within(0.01).of(45)
      end
    end

    context '.top_oldest_non_admins' do
      it 'returns three oldest users except admins' do
        create(:admin, created_at: 3.years.ago, first_name: 'not expected')
        create(randmon_non_admin_role, created_at: 9.days.ago, first_name: 'not expected')
        create(randmon_non_admin_role, created_at: 10.days.ago, first_name: 'expected')
        create(randmon_non_admin_role, created_at: 11.days.ago, first_name: 'expected')
        create(randmon_non_admin_role, created_at: 12.days.ago, first_name: 'expected')

        result = User.top_oldest_non_admins

        expect(result.count).to eq 3
        expect(result.map(&:first_name))
          .to match_array(%w(expected expected expected))
      end
    end

    context '#full_name' do
      it 'should concatenate first_name and last_name' do
        user = build(:user, first_name: 'Alex', last_name: 'Beznos')
        expect(user.full_name).to eq('Alex Beznos')
      end
    end
  end


  def randmon_non_admin_role
    %i(manager employee).sample
  end
end
