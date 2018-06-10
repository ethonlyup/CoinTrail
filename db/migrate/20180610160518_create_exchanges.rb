class CreateExchanges < ActiveRecord::Migration[5.2]
  def change
    create_table :exchanges do |t|
      t.string :base_endpoint
      t.string :name
    end
  end
end
