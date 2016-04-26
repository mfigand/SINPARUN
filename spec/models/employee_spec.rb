require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'validations' do

    it 'Create a valid employee' do
      expect(FactoryGirl.create(:employee)).to be_valid
    end

    it 'Not valid without a name' do
      expect(FactoryGirl.build(:employee, name: nil)).not_to be_valid
    end

    it 'Not valid without a password' do
      expect(FactoryGirl.build(:employee, password: nil)).not_to be_valid
    end

    it 'Not valid without a phone' do
      expect(FactoryGirl.build(:employee, phone: nil)).not_to be_valid
    end

    it 'Not valid without a email' do
      expect(FactoryGirl.build(:employee, email: nil)).not_to be_valid
    end

    context 'Not allow two employees with the same email' do
      before (:each) do
        @employee1 = Employee.create({ name: 'Manu', email: 'test@test.com'})
      end

      it 'it should save just the first employees' do
        expect(@employee2 = Employee.create({ name: 'Otro', email: 'test@test.com' })).not_to be_valid
      end
    end

  end

  describe 'associations' do

    it 'Relates employee to a branch' do
      branch = FactoryGirl.create(:company)
      employee = FactoryGirl.create(:employee, branch_id: branch.id)
      expect(branch).eql?(employee.branch)
    end

    it 'Relates employee to coupons' do
      employee = FactoryGirl.create(:employee)
      coupon = FactoryGirl.create(:coupon, employee_id: employee.id)
      expect(employee.coupons[0]).eql?(coupon)
    end

  end
  
end
