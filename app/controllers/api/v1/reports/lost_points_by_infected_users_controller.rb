# frozen_string_literal: true

class Api::V1::Reports::LostPointsByInfectedUsersController < ApplicationController
  # GET /api/v1/reports/lost_points_by_infected_users
  def index
    render json: { points: Reports::LostPointsByInfectedUser.points }
  end
end
