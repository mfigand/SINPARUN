require 'rails_helper'

RSpec.describe BranchesController, type: :controller do

    before (:each) do
      @user = FactoryGirl.create(:user, name: 'Manu')
      sign_in @user
    end

    it "should have a current_user" do
      # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
      expect(subject.current_user).to_not eq(nil)
    end
    
end
