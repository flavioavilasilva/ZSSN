# frozen_string_literal: true

class Reports::BaseInfectedUser
  def self.percentage
    total_users = User.all.count
    return 'Dados insuficientes' if total_users < 1 || query_count < 1

    query_count * 100 / total_users
  end

  def self.query_count
    0
  end
end
