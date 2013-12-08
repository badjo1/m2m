class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
      add_column :parties, :remember_token, :string
	  add_index  :parties, :remember_token
  end
end
