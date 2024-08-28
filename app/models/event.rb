class Event < ApplicationRecord
  belongs_to :sport
  belongs_to :location
  has_many :orders
end
