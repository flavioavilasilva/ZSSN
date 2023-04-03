class InfectedAlert < ApplicationRecord
  belongs_to :user
  belongs_to :warned_by, class_name: 'User'

  after_save :set_user_infected

  def set_user_infected
    return if self.user.infected || InfectedAlert.where(user_id: self.user_id).count <= 2
    
    self.user.update_attribute(:infected, true)
  end
end
