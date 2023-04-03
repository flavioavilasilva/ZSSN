class Api::V1::Reports::InfectedUsersController < ApplicationController
  # GET /api/v1/reports/infected_users
  def index
    total_users = User.all.count
    infected_users_count = User.where(infected: true).count

    render json: { porcentagem_usuarios_infectados: infected_users_count * total_users / 100 }
  end
end
