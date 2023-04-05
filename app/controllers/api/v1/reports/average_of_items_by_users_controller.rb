# frozen_string_literal: true

class Api::V1::Reports::AverageOfItemsByUsersController < ApplicationController
  # GET /api/v1/reports/average_of_items_by_users
  def index
    render json: { items: Reports::AverageOfItemsByUser.items }
  end
end
