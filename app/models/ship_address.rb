class ShipAddress < ApplicationRecord
  validates :name, :city, :district, :ward, presence: true
  belongs_to :user
  belongs_to :order, optional: true
end
