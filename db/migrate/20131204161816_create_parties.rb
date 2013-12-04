class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :name
      t.string :email
	  t.string :password_digest
      t.timestamps
    end
    add_index :parties, :email, unique: true
    
  end
end
