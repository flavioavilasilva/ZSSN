class User < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :infected_alerts

  scope :infected_users, -> { where(infected: true) }
  scope :not_infected_users, -> { where(infected: false) }
end
