class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :edit, :update, :destroy]

  def create
    @alert = Alert.new(alert_params)
    @alert.user = current_user
    if @alert.save
      redirect_to alerts_path, notice: "Alert created successfully"
    else
      render :new
    end
  end

  def destroy
    @alert.destroy
    redirect_to alerts_path, notice: "Alert deleted successfully"
  end

  def update
    @alert.update(alert_params)
    redirect_to alert_path(@alert)
  end

  def new
    @alert = Alert.new
    @user = User.find(current_user.id)
  end

  def show
  end

  def index
    @alerts = Alert.where(user: current_user)
  end

  def edit
  end

  private

  def set_alert
    @alert = Alert.find(params[:id])
  end

  def alert_params
    params.require(:alert).permit(:coin_name, :price_above)
  end

end
