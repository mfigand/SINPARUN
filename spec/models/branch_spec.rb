require 'rails_helper'

RSpec.describe Branch, type: :model do

  describe 'validations' do

     it 'Create a valid Branch' do
       expect(FactoryGirl.create(:branch)).to be_valid
     end

     it 'Not valid without a name' do
       expect(FactoryGirl.build(:branch, name: nil)).not_to be_valid
     end

     it 'Not valid without a phone' do
       expect(FactoryGirl.build(:branch, phone: nil)).not_to be_valid
     end

     it 'Not valid without a address' do
       expect(FactoryGirl.build(:branch, address: nil)).not_to be_valid
     end

     it 'Not valid without a latitude' do
       expect(FactoryGirl.build(:branch, latitude: nil)).not_to be_valid
     end

     it 'Not valid without a longitude' do
       expect(FactoryGirl.build(:branch, longitude: nil)).not_to be_valid
     end

     it 'Not valid without a city' do
       expect(FactoryGirl.build(:branch, city: nil)).not_to be_valid
     end

     context 'Not allow two branches with the same name' do
       before (:each) do
         @branch1 = Branch.create({ name: 'Manu branch', address: 'plaza mayor', phone:'555666777', latitude:"40.36604328395403", longitude:'-3.711733472872652', city:'Madrid'})
         @branch2 = Branch.create({ name: 'Manu branch', address: 'sol', phone:'555666777', latitude:"40.36604328395403", longitude:'-3.711733472872652', city:'Madrid'})
       end

       it 'it should save just the first branch' do
         branch = Branch.last
         expect(branch.address).eql?('plaza mayor')
       end
     end

     context 'Not allow two companies with the same address' do
       before (:each) do
         @branch1 = Branch.create({ name: 'Manu branch', address: 'plaza mayor', phone:'555666777', latitude:"40.36604328395403", longitude:'-3.711733472872652', city:'Madrid'})
         @branch2 = Branch.create({ name: 'Otro', address: 'plaza mayor', phone:'555666777', latitude:"40.36604328395403", longitude:'-3.711733472872652', city:'Madrid'})
       end

       it 'it should save just the first company' do
         branch = Branch.last
         expect(branch.name).eql?('Manu branch')
       end
     end

  end

  describe 'associations' do

    it 'Relates branches and rewards' do
      branch = FactoryGirl.create(:branch)
      reward = FactoryGirl.create(:reward, branch_id: branch.id)
      expect(branch.rewards[0]).eql?(reward)
    end

    it 'Relates branches and employee' do
      branch = FactoryGirl.create(:branch)
      employee = FactoryGirl.create(:employee, branch_id: branch.id)
      expect(branch.rewards[0]).eql?(branch)
    end

    it 'Relates branches and company' do
      company = FactoryGirl.create(:company)
      branch = FactoryGirl.create(:branch, company_id: company.id)
      expect(company.rewards[0]).eql?(branch)
    end

  end

end
