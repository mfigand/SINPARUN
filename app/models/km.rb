class Km < ActiveRecord::Base

  belongs_to :user

  validates :sinparun_kms, :total_kms, :level, :races, :user_id, presence: true
  
end
