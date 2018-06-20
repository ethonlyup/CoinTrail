class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :edit, :update, :destroy]

  def create
    @alert = Alert.new(alert_params.merge(user: current_user))
    if @alert.save
      redirect_to new_alert_path, notice: "Alert created successfully"
    else
      render :new
    end
  end

  def destroy
    @alert.destroy
    redirect_to new_alert_path, notice: "Alert deleted successfully"
  end

  def update
    @alert.update(alert_params)
    redirect_to alert_path(@alert)
  end

  def new
    @alerts = Alert.where(user: current_user)
    @alert = Alert.new
    @coin_name = params[:coin_name]
    @coin_price = params[:coin_price].to_f.round(2)
  end

  def show
  end

  def edit
  end

  private

  def set_alert
    @alert = Alert.find(params[:id])
  end

  def alert_params
    params.require(:alert).permit(:coin_name, :price_above, :price_below)
  end

end
