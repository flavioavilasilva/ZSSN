class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :user

  belongs_to :user

  VALID_ITEMS = { water: 4, food: 3, medicine: 2, ammo: 1 }
end
