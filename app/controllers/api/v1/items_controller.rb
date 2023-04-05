class Api::V1::ItemsController < ApplicationController
  before_action :set_api_v1_user_item, only: %i[show update destroy]

  # GET /api/v1/users/1/items
  def index
    @api_v1_user_items = Item.all

    render json: @api_v1_user_items
  end

  # GET /api/v1/users/1/items/1
  def show
    render json: @api_v1_user_item
  end

  # POST /api/v1/users/1/items
  def create
    @api_v1_user_item = Item.new(api_v1_user_item_params)

    return render json: @api_v1_user_item.errors, status: :unprocessable_entity unless @api_v1_user_item.valid?

    if @api_v1_user_item.save
      render json: {}, status: :created
    else
      render json: @api_v1_user_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1/items/1
  def update
    if @api_v1_user_item.update(api_v1_user_item_params)
      render json: @api_v1_user_item
    else
      render json: @api_v1_user_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/1/items/1
  def destroy
    @api_v1_user_item.destroy
  end

  private

  def set_api_v1_user_item
    @api_v1_user_item = Item.find(params[:id])
  end

  def api_v1_user_item_params
    params.permit(:name, :user_id)
  end
end
