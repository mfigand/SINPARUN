class Reward < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  belongs_to :branch
  has_many :coupons

  validates :name, presence: true, length: { maximum: 15}, format: {with: /\A[a-zA-ZÑñ0-9\ ]+\z/}
  validates :kms_cost, :available_units, :description, :valid_from, :valid_through, :image, presence: true

  has_attached_file :image, styles: { medium: "300x300>", small: "200x200!", xsmall: "150x150>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [:sorted_by, :search_query])

  scope :sorted_by, lambda { |sort_option|
  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  case sort_option.to_s
  when /^created_at_/

    order("rewards.created_at #{ direction }")
  else
    raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
  end
}

  scope :with_city, lambda { |city|
    where(city: [*city])
  }

  scope :search_query, lambda { |query|
  return nil  if query.blank?
  return nil if query.class == Fixnum

  terms = query.downcase.split(/\s+/)

  terms = terms.map { |e|
    (e.gsub('*', '%') + '%').gsub(/%+/, '%')
  }

  num_or_conds = 2
  where(
    terms.map { |term|
      "(LOWER(rewards.name) LIKE ? OR LOWER(rewards.name) LIKE ?)"
    }.join(' AND '),
    *terms.map { |e| [e] * num_or_conds }.flatten
  )
}

def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Registration date (newest first)', 'created_at_desc'],
      ['Registration date (oldest first)', 'created_at_asc'],
    ]
  end

end
