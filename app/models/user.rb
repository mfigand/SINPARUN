class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :coupons
  has_many :kms

  validates :name, presence: true, length: { maximum: 250 }
  validates :email, uniqueness: true
  validates :password, presence: true, format: {with: /\A[a-zA-ZÑñ0-9\ ]+\z/}
  # validates :password, length: { minumum: 8 }
  # validates_each :password do |record, attr, value|
  #   record.errors.add(attr, 'must start with upper case') if value =~ /\A[[:lower:]]/
  #   end
  # /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{8,}$/

 has_attached_file :avatar, styles: {
   medium: "300x300>",
   small: "200x200!",
   xsmall: "150x150>",
   thumb: "100x100>" },
   default_url: "/images/avatar1.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def self.new_runner_nike(current_user,params)
    current_user_kms = Km.create(sinparun_kms:0,
     total_kms:0,
     nike_last_total_kms:params[:totalDistance].to_i,
     level: 1, races: 1, user_id:current_user.id)
  end

  def self.new_nike_account(current_user,params)
    kms_accounts = current_user.kms[0]
    kms_accounts.nike_last_total_kms = params[:totalDistance].to_i
    kms_accounts.save
    kms_accounts
  end

  def self.update_runner_nike(current_user,params)
    kms_accounts = current_user.kms[0]
    if params[:totalDistance].to_i > kms_accounts.nike_last_total_kms
      nike_new_kms = params[:totalDistance].to_i - kms_accounts.nike_last_total_kms
      kms_accounts.sinparun_kms = kms_accounts.sinparun_kms + nike_new_kms
      kms_accounts.total_kms = kms_accounts.total_kms + nike_new_kms
      kms_accounts.nike_last_total_kms = params[:totalDistance].to_i
      kms = kms_accounts.total_kms
      level = kms/100 == 0 ? 1 : (kms/100 + 1)
      kms_accounts.level = level
      kms_accounts.races = kms_accounts.races + 1
      kms_accounts.save
      kms_accounts
      kms_accounts
   else
    kms_accounts
   end
  end

  def self.new_runner_runtastic(current_user,params)
    current_user_kms = Km.create(sinparun_kms:0,
     total_kms:0,
     runtastic_last_total_kms:params[:totalDistance].to_i,
     level: 1, races: 1, user_id:current_user.id)
  end

  def self.new_runtastic_account(current_user,params)
    kms_accounts = current_user.kms[0]
    kms_accounts.runtastic_last_total_kms = params[:totalDistance].to_i
    kms_accounts.save
    kms_accounts
  end

  def self.update_runner_runtastic(current_user,params)
    kms_accounts = current_user.kms[0]
    if params[:totalDistance].to_i > kms_accounts.runtastic_last_total_kms
      runtastic_new_kms = params[:totalDistance].to_i - kms_accounts.runtastic_last_total_kms
      kms_accounts.sinparun_kms = kms_accounts.sinparun_kms + runtastic_new_kms
      kms_accounts.total_kms = kms_accounts.total_kms + runtastic_new_kms
      kms_accounts.runtastic_last_total_kms = params[:totalDistance].to_i
      kms = kms_accounts.total_kms
      level = kms/100 == 0 ? 1 : (kms/100 + 1)
      kms_accounts.level = level
      kms_accounts.races = kms_accounts.races + 1
      kms_accounts.save
      kms_accounts
      kms_accounts
   else
    kms_accounts
   end
  end

end
