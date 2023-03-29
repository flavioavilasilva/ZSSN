class InfectedAlert < ApplicationRecord
  belongs_to :user
  belongs_to :warned_by, class_name: 'User'
end
