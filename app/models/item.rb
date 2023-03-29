class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :user

  belongs_to :user
end
