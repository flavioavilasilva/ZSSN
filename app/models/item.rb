class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :user
  validates_with Validators::NameItemsValidator
  validates_with Validators::InfectedUsersValidator

  belongs_to :user

  after_initialize :set_points  

  VALID_ITEMS = { water: 4, food: 3, medicine: 2, ammo: 1 }

  def set_points
    return if self.name.nil? || VALID_ITEMS.keys.include?(self.name.to_sym) == false

    self.points = VALID_ITEMS[self.name.to_sym]
  end
end
