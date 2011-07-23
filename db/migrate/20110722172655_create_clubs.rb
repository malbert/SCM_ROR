class CreateClubs < ActiveRecord::Migration
  def self.up
    create_table :clubs do |t|
      t.string :title, :null => false, :default => ""
      t.text :description, :null => true
      t.text :schedule, :null => true
      t.string :address, :null => false, :default => ""
      t.string :zip, :null => false, :default => ""
      t.string :town, :null => false, :default => ""
      t.string :country, :null => false, :default => ""
      
      t.string :logo_file_name
      t.string :logo_content_type
      t.string :logo_file_size
      t.datetime :logo_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :clubs
  end
end
