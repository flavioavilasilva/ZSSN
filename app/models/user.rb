class User < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :infected_alerts
end
