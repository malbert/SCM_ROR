class CreateGrades < ActiveRecord::Migration
  def self.up
    create_table :grades do |t|
      t.string :name, :size => 60, :required => true, :default => ""
      t.integer :grade_order, :required => true, :default => 0
      t.boolean :template, :required => true, :default => 1
      t.string :language, :size => 2, :required => false, :default => "en"
      t.integer :age_minimum, :required => true, :default => 0
      t.boolean :is_presence_required, :required => true, :default => 1
      t.integer :presence_required, :required => false

      t.timestamps
    end
    
    create_table :arts_grades do |t|
      t.integer :art_id, :required => true, :default => 0
      t.integer :grade_id, :required => true, :default => 0

      t.timestamps
    end
    
    load_data
  end
  
  def self.load_data
    Grade.create(:name => 'Ceinture blanche', :grade_order => 1, :template => 1, :language => 'fr', :age_minimum => 6, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Ceinture jaune', :grade_order => 2, :template => 1, :language => 'fr', :age_minimum => 8, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Ceinture orange', :grade_order => 3, :template => 1, :language => 'fr', :age_minimum => 10, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Ceinture verte', :grade_order => 4, :template => 1, :language => 'fr', :age_minimum => 12, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Ceinture bleue', :grade_order => 5, :template => 1, :language => 'fr', :age_minimum => 14, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Ceinture marron', :grade_order => 6, :template => 1, :language => 'fr', :age_minimum => 15, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Ceinture noire 1er dan', :grade_order => 7, :template => 1, :language => 'fr', :age_minimum => 16, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Ceinture noire 2eme dan', :grade_order => 8, :template => 1, :language => 'fr', :age_minimum => 6, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Ceinture noire 3eme dan' , :grade_order => 9, :template => 1, :language => 'fr', :age_minimum => 6, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Ceinture noire 4eme dan', :grade_order => 10, :template => 1, :language => 'fr', :age_minimum => 6, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Ceinture noire 5eme dan', :grade_order => 11, :template => 1, :language => 'fr', :age_minimum => 6, :is_presence_required => 1, :presence_required => 0)  
    
    Grade.create(:name => 'White belt', :grade_order => 1, :template => 1, :language => 'en', :age_minimum => 6, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Yellow belt', :grade_order => 2, :template => 1, :language => 'en', :age_minimum => 8, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Orange belt', :grade_order => 3, :template => 1, :language => 'en', :age_minimum => 10, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Green belt', :grade_order => 4, :template => 1, :language => 'en', :age_minimum => 12, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Blue belt', :grade_order => 5, :template => 1, :language => 'en', :age_minimum => 14, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Brown belt', :grade_order => 6, :template => 1, :language => 'en', :age_minimum => 15, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Black belt 1st dan', :grade_order => 7, :template => 1, :language => 'en', :age_minimum => 16, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Black belt 2nd dan', :grade_order => 8, :template => 1, :language => 'en', :age_minimum => 6, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Black belt 3rd dan' , :grade_order => 9, :template => 1, :language => 'en', :age_minimum => 6, :is_presence_required => 1, :presence_required => 0)  
    Grade.create(:name => 'Black belt 4th dan', :grade_order => 10, :template => 1, :language => 'en', :age_minimum => 6, :is_presence_required => 1, :presence_required => 0)  
    
  end

  def self.down
    drop_table :grades
    drop_table :arts_grades
  end
end
