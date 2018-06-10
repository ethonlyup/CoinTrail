class CreateApis < ActiveRecord::Migration[5.2]
  def change
    create_table :apis do |t|
      t.string :publishable_key
      t.string :secret_key
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
