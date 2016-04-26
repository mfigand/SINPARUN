require 'rails_helper'

RSpec.describe Site, type: :model do

    it 'Returns total kms in json from fake nike_api' do
      expect(Site.all_activities_nike).to_json
    end

    it 'Returns total kms in json from fake runtastic_api' do
      expect(Site.all_activities_runtastic).to_json
    end

end
