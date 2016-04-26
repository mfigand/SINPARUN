require 'rails_helper'

RSpec.describe Km, type: :model do

  describe 'validations' do

    it 'Create a valid km account' do
      expect(FactoryGirl.create(:km)).to be_valid
    end

    it 'Not valid without a sinparun_kms' do
      expect(FactoryGirl.build(:km, sinparun_kms: nil)).not_to be_valid
    end

    it 'Not valid without a total_kms' do
      expect(FactoryGirl.build(:km, total_kms: nil)).not_to be_valid
    end

    it 'Not valid without a level' do
      expect(FactoryGirl.build(:km, level: nil)).not_to be_valid
    end

    it 'Not valid without a races' do
      expect(FactoryGirl.build(:km, races: nil)).not_to be_valid
    end

    it 'Not valid without a user id' do
      expect(FactoryGirl.build(:km, user_id: nil)).not_to be_valid
    end

  end

  describe 'associations' do

    it 'Relates km to a user' do
      user = FactoryGirl.create(:user)
      km = FactoryGirl.create(:km, user_id: user.id)
      expect(km).eql?(user.kms)
    end

  end

end
