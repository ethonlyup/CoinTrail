class ApisController < ApplicationController
  before_action :set_api, only: [:edit, :destroy]

  def new
    @api = Api.new
  end

  def create
    @api = Api.new(api_params)
    if @api.save
      redirect_to @api, notice: 'API connection was successfully created'
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def set_api
    @api = Api.find(params[:id])
  end

  def api_params
    params.require(:api).permit(:publishable_key, :secret_key, :exchange)
  end
end

