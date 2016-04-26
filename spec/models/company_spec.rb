require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validations' do

     it 'Create a valid Company' do
       expect(FactoryGirl.create(:company)).to be_valid
     end

     it 'Not valid without a name' do
       expect(FactoryGirl.build(:company, name: nil)).not_to be_valid
     end

     it 'Not valid without a email' do
       expect(FactoryGirl.build(:company, email: nil)).not_to be_valid
     end

     it 'Not valid without a password' do
       expect(FactoryGirl.build(:company, password: nil)).not_to be_valid
     end

     context 'Not allow two companies with the same email' do
       before (:each) do
         @company1 = Company.create({ name: 'Manu', email: 'manu@gmail.com', password:'12345678'})
         @company2 = Company.create({ name: 'Otro', email: 'manu@gmail.com', password:'12345678'})
       end

       it 'it should save just the first company' do
         company = Company.last
         expect(company.name).eql?('Manu')
       end
     end

     context 'Not allow two companies with the same name' do
       before (:each) do
         @company1 = Company.create({ name: 'Manu SA', email: 'manusa@gmail.com', password:'12345678'})
         @company2 = Company.create({ name: 'Manu SA', email: 'otro@gmail.com', password:'12345678'})
       end

       it 'it should save just the first company' do
         company = Company.last
         expect(company.email).eql?('manusa@gmail.com')
       end
     end

  end

  describe 'associations' do

    it 'Relates company and rewards' do
      company = FactoryGirl.create(:company)
      reward = FactoryGirl.create(:reward, company_id: company.id)
      expect(company.rewards[0]).eql?(reward)
    end

    it 'Relates company and branches' do
      company = FactoryGirl.create(:company)
      branch = FactoryGirl.create(:branch, company_id: company.id)
      expect(company.rewards[0]).eql?(branch)
    end

  end
  
end
