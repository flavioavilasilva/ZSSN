# frozen_string_literal: true

class Reports::InfectedUser < Reports::BaseInfectedUser
  def self.query_count
    User.infected_users.count
  end
end
