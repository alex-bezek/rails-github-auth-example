class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      # Required fields for omniauth
      t.string :user_name, null: false
      t.string :provider, null: false
      t.string :uid, null: false

      # Additional fields for github auth
      t.string :avatar_url
      t.string :email
      t.string :oauth_token

      t.timestamps
    end
  end
end
