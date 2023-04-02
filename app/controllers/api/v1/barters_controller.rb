class Api::V1::BartersController < ApplicationController
  # POST /api/v1/barters
  def create
    barter = Barter.new(api_v1_barter_params[:given_items], api_v1_barter_params[:receiven_items])

    @api_v1_barter = BarterService.new(barter).call

    if @api_v1_barter
      render json: {}, status: :created
    else
      render json: barter.errors, status: :unprocessable_entity
    end
  end

  private
    def api_v1_barter_params
      params.permit(:given_items, :receiven_items)
    end
end
