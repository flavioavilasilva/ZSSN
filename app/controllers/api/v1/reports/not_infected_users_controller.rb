# frozen_string_literal: true

class Api::V1::Reports::NotInfectedUsersController < ApplicationController
  # GET /api/v1/reports/not_infected_users
  def index
    render json: { not_infected_users_percentage: Reports::NotInfectedUser.percentage }
  end
end
