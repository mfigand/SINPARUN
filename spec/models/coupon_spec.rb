require 'rails_helper'

RSpec.describe Coupon, type: :model do

   describe 'validations' do

      it 'Create a valid coupon' do
        expect(FactoryGirl.create(:coupon)).to be_valid
      end

      it 'Not valid without a code' do
        expect(FactoryGirl.build(:coupon, code: nil)).not_to be_valid
      end

      it 'Not valid without a kms_cost' do
        expect(FactoryGirl.build(:coupon, kms_cost: nil)).not_to be_valid
      end

      it 'Not valid without a redeemed' do
        expect(FactoryGirl.build(:coupon, redeemed: nil)).not_to be_valid
      end

      context 'Not allow two coupons with the same code' do
        before (:each) do
          @coupon1 = Coupon.create({ code: '12345678'})
        end

        it 'it should save just the first employees' do
          expect(@coupon2 = Coupon.create({ code: '12345678'})).not_to be_valid
        end
      end

   end

   describe 'associations' do

     it 'Relates coupons and users' do
       user = FactoryGirl.create(:user)
       coupon = FactoryGirl.create(:coupon, user_id: user.id)
       expect(user.coupons[0]).eql?(coupon)
     end

     it 'Relates coupons and employees' do
       employee = FactoryGirl.create(:employee)
       coupon = FactoryGirl.create(:coupon, employee_id: employee.id)
       expect(employee.coupons[0]).eql?(coupon)
     end

     it 'Relates coupons and rewards' do
       reward = FactoryGirl.create(:reward)
       coupon = FactoryGirl.create(:coupon, reward_id: reward.id)
       expect(reward.coupons[0]).eql?(coupon)
     end

   end

   it "Generate unic code" do
     @code1 = Coupon.generate_code
     @code2 = Coupon.generate_code
     expect(@code1).not_to be(@code2)
   end

   it "Subtraction one unit from available units once a runner get the reward" do
     reward = FactoryGirl.build(:reward, available_units: 10)
     Coupon.subtract_available_units(reward)
     expect(reward.available_units).to be(9)
   end

   it "Sum one unit to reserved units when substract from available units" do
     reward = FactoryGirl.build(:reward, reserved_units: 0)
     Coupon.subtract_available_units(reward)
     expect(reward.reserved_units).to be(1)
   end

   it "Subtraction one unit from reserved units once a runner change the reward" do
     reward = FactoryGirl.build(:reward, reserved_units: 1)
     Coupon.subtract_reserved_units(reward)
     expect(reward.reserved_units).to be(0)
   end

   it "Sum one unit to charged units when substract from reserved units" do
     reward = FactoryGirl.build(:reward, charged_units: 0)
     Coupon.subtract_reserved_units(reward)
     expect(reward.charged_units).to be(1)
   end

end
