class Api::V1::Reports::InfectedUsersController < ApplicationController
  # GET /api/v1/reports/infected_users
  def index
    render json: { infected_users_percentage: Reports::InfectedUser.percentage }
  end
end
