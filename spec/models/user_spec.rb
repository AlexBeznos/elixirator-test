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
  end
end
