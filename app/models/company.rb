class Company < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :rewards
   has_many :branches

   validates :name, :email, uniqueness: true, presence: true, length: { maximum: 250 }
   validates :password, presence: true

end
