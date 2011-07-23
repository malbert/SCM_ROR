class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table :plans do |t|
      t.string :title, :size => 25, :null => false
      t.float :monthly_fees, :null => true, :default => 0
      t.float :yearly_fees, :null => true, :default => 0
      t.string :currency, :size => 3, :null => false
      t.boolean :is_active, :null => false, :default => 0
      t.string :description, :null => false
      t.timestamps
    end
    
    load_data
  end
  
  def self.load_data
    Plan.create(:title => 'Premium', :monthly_fees => 5, :yearly_fees => 50, :currency => 'EUR', :is_active => 1, :description => 'This plan is made for federation encompassing several dojo.')  
    Plan.create(:title => 'Standard', :monthly_fees => 6, :yearly_fees => 60, :currency => 'EUR', :is_active => 1, :description => 'This plan is addressed to the persons managing a single dojo.') 
    Plan.create(:title => 'Free', :monthly_fees => 0, :yearly_fees => 0, :currency => 'EUR', :is_active => 1, :description => 'This plan allows you to have a public page.')  
  end
  
  def self.down
    drop_table :plans
  end
end
