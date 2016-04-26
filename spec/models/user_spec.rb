require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do

    it 'Create a valid factory' do
      expect(FactoryGirl.create(:user)).to be_valid
    end

    it 'Not valid without a name' do
      expect(FactoryGirl.build(:user, name: nil)).not_to be_valid
    end

    it 'Not valid without a email' do
      expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
    end

    it 'Not valid without a password' do
      expect(FactoryGirl.build(:user, password: nil)).not_to be_valid
    end

  end

  describe 'associations' do

    it 'Relates user and kms account' do
      user = FactoryGirl.create(:user)
      km = FactoryGirl.create(:km, user_id: user.id)
      expect(user.kms[0]).eql?(km)
    end

    it 'Relates user and coupons' do
      user = FactoryGirl.create(:user)
      coupon = FactoryGirl.create(:coupon, user_id: user.id)
      expect(user.coupons[0]).eql?(coupon)
    end

  end

  describe '#new_runner' do
    before (:each) do
      @user = FactoryGirl.create(:user)
      @coupon = FactoryGirl.create(:coupon, user_id: @user.id)
      @km = FactoryGirl.create(:km, user_id: @user.id)
      @reward = FactoryGirl.create(:reward)
    end

    it 'Creates a km account for new users' do
      expect(@user.kms.length).to eq(1)
    end
  end

  describe '#update_runner' do
    before (:each) do
      @user = FactoryGirl.create(:user)
      @coupon = FactoryGirl.create(:coupon, user_id: @user.id)
      @km = FactoryGirl.create(:km, user_id: @user.id)
      @reward = FactoryGirl.create(:reward)
    end

    it 'Update the sinparun kms' do
      expect(@user.kms[0].sinparun_kms).to be(@km.sinparun_kms)
    end

    it 'Update the total kms' do
      expect(@user.kms[0].total_kms).to be(@km.total_kms)
    end

    it 'Update the nike last kms' do
      expect(@user.kms[0].nike_last_total_kms).to be(@km.nike_last_total_kms)
    end

    it 'Update the level kms' do
      expect(@user.kms[0].level).to be(@km.level)
    end

    it 'Update the races kms' do
      expect(@user.kms[0].races).to be(@km.races)
    end
  end

  context 'Not allow two users with the same email' do
    before (:each) do
      @user1 = User.create({ name: 'Manu', email: 'manu@gmail.com'})
      @user2 = User.create({ name: 'Otro', email: 'manu@gmail.com' })
    end

    it 'it should save just the first user' do
      user = User.last
      expect(user.name).eql?('Manu')
    end
  end

end
