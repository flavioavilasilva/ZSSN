# frozen_string_literal: true

class Api::V1::InfectedAlertsController < ApplicationController
  before_action :set_api_v1_infected_alert, only: %i[show update destroy]

  # GET /api/v1/users/1/infected_users
  def index
    @api_v1_infected_alerts = InfectedAlert.where(user_id: params['user_id'])
                                           .all

    render json: @api_v1_infected_alerts
  end

  # GET /api/v1/users/1/infected_users/1
  def show
    render json: @api_v1_infected_alerts
  end

  # POST /api/v1/users/1/infected_users
  def create
    @api_v1_infected_alerts = InfectedAlert.new(api_v1_infected_alert_params)

    if @api_v1_infected_alerts.save
      render json: @api_v1_infected_alerts.to_json, status: :created
    else
      render json: @api_v1_infected_alerts.errors, status: :unprocessable_entity
    end
  end

  private

  def set_api_v1_infected_alert
    @api_v1_infected_alerts = InfectedAlert.find(params[:id])
  end

  def api_v1_infected_alert_params
    params.require(:infected_alert)
          .permit(:user_id, :warned_by_id)
          .merge(user_id: params['user_id']) || {}
  end
end
