class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :username
      t.string :email
      t.string :address
      t.string :town
      t.string :zip
      t.string :country
      t.string :language
      t.integer :admin

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
