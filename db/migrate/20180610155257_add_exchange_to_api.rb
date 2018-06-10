class AddExchangeToApi < ActiveRecord::Migration[5.2]
  def change
    add_reference :apis, :exchange, foreign_key: true
  end
end
