class CreateAlerts < ActiveRecord::Migration[5.2]
  def change
    create_table :alerts do |t|
      t.string :coin_name
      t.float :price_above
      t.float :price_below
      t.references :user, foreign_key: true
    end
  end
end
