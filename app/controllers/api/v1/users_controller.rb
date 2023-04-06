# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  before_action :set_api_v1_user, only: %i[show update destroy]

  # GET /api/v1/users
  def index
    @api_v1_users = User.not_infected_users

    render json: @api_v1_users
  end

  # GET /api/v1/users/1
  def show
    render json: @api_v1_user
  end

  # POST /api/v1/users
  def create
    @api_v1_user = User.new(api_v1_user_params)

    if @api_v1_user.save
      render json: @api_v1_user.to_json, status: :created
    else
      render json: @api_v1_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1
  def update
    return render json: {}, status: :unprocessable_entity if api_v1_user_params.blank?

    if @api_v1_user.update(api_v1_user_params)
      render json: @api_v1_user.to_json
    else
      render json: @api_v1_user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_api_v1_user
    @api_v1_user = User.find(params[:id])
  end

  def api_v1_user_params
    params.permit(:name, :gender, :age, :latitude, :longitude)
  end

  def valid_params?
    return false if api_v1_user_params[:name].nil?

    true
  end
end
