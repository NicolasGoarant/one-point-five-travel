class Destination < ApplicationRecord
  belongs_to :country
  has_many :trips

  scope :featured, -> { where(featured: true) }
  scope :train_accessible, -> { where(accessible_by_train: true) }

  def full_name
    "#{name}, #{country.name}"
  end
end
