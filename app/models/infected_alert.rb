# frozen_string_literal: true

class InfectedAlert < ApplicationRecord
  belongs_to :user
  belongs_to :warned_by, class_name: 'User'

  validates_with Validators::InfectedAlert::WarnedByValidator

  after_save :set_user_infected

  def set_user_infected
    return if user.infected || InfectedAlert.where(user_id:).count <= 2

    user.update_attribute(:infected, true)
  end
end
