class ApisController < ApplicationController
  before_action :set_api, only: [:edit, :destroy]

  def new
    @apis = Api.where(user: current_user)
    @api = Api.new
    @exchanges = Exchange.all - current_user.apis.map {|e| e.exchange}.uniq
  end

  def create
    @api = Api.new(api_params.merge(user: current_user))
    if @api.save!
      redirect_to new_api_path, notice: 'API connection was successfully created'
    else
      render :new
    end
  end

  def update
  end

  def destroy
    @api = Api.find(params[:id])
    @api.destroy
    redirect_to new_api_path
  end

  private

  def set_api
    @api = Api.find(params[:id])
  end

  def api_params
    params.require(:api).permit(:publishable_key, :secret_key, :exchange_id)
  end
end

