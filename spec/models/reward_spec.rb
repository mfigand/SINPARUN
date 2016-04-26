require 'rails_helper'

RSpec.describe Reward, type: :model do

  describe 'validations' do

    it 'Create a valid reward' do
      expect(FactoryGirl.create(:reward)).to be_valid
    end

    it 'Not valid without a name' do
      expect(FactoryGirl.build(:reward, name: nil)).not_to be_valid
    end

    it 'Not valid without a kms_cost' do
      expect(FactoryGirl.build(:reward, kms_cost: nil)).not_to be_valid
    end

    it 'Not valid without a available_units' do
      expect(FactoryGirl.build(:reward, available_units: nil)).not_to be_valid
    end

    it 'Not valid without a description' do
      expect(FactoryGirl.build(:reward, description: nil)).not_to be_valid
    end

    it 'Not valid without a valid_from' do
      expect(FactoryGirl.build(:reward, valid_from: nil)).not_to be_valid
    end

    it 'Not valid without a valid_through' do
      expect(FactoryGirl.build(:reward, valid_through: nil)).not_to be_valid
    end

    it 'Not valid without a image' do
      expect(FactoryGirl.build(:reward, image: nil)).not_to be_valid
    end
    
  end

  describe 'associations' do

    it 'Relates reward and branches' do
      branch = FactoryGirl.create(:branch)
      reward = FactoryGirl.create(:reward, branch_id: branch.id)
      expect(branch.rewards[0]).eql?(reward)
    end

    it 'Relates reward and company' do
      company = FactoryGirl.create(:company)
      reward = FactoryGirl.create(:reward, company_id: company.id)
      expect(company.rewards[0]).eql?(company)
    end

    it 'Relates rewards and coupons' do
      reward = FactoryGirl.create(:reward)
      coupon = FactoryGirl.create(:coupon, reward_id: reward.id)
      expect(reward.coupons[0]).eql?(coupon)
    end

  end


end
