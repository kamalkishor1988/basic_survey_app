class Survey < ApplicationRecord
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true

  validates_presence_of :title
  validates_uniqueness_of :title
end
