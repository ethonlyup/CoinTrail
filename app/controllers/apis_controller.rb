class ApisController < ApplicationController
  def new
    if current_user.publishable_key && current_user.secret_key
      @api = Api.new
    else
      notice: 'Please ensure both fields are entered before creating an API connection'
    end
  end

  def update
  end

  def create
  end

  def destroy
  end
end

def edit
end
