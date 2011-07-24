class CreateArts < ActiveRecord::Migration
  def self.up
    create_table :arts do |t|
      t.string :name, :size => 60, :required => true, :default => ""
      t.boolean :template, :required => true, :default => 1
        
      t.timestamps
    end
    
    create_table :clus_arts do |t|
      t.integer :club_id, :required => true, :default => 0
      t.integer :art_id, :required => true, :default => 0

      t.timestamps
    end
    
    load_data
  end
  
  def self.load_data
    Art.create(:name => 'Tai-do', :template => true)  
    Art.create(:name => 'Ju-jitsu', :template => true)  
    Art.create(:name => 'Kobudo', :template => true)  
  end

  def self.down
    drop_table :arts
    drop_table :clubs_arts
  end
end
