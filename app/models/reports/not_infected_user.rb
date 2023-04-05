# frozen_string_literal: true

class Reports::NotInfectedUser < Reports::BaseInfectedUser
  def self.query_count
    User.not_infected_users.count
  end
end
