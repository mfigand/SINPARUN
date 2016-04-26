class Branch < ActiveRecord::Base
  has_many :rewards
  has_many :employees
  belongs_to :company

  validates :name, :address, uniqueness: true, presence: true, length: { maximum: 250 }
  validates :phone, :latitude, :longitude, :city, presence: true

end
