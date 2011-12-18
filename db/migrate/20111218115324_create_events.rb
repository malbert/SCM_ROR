class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, :null => false
      t.datetime :starts_at, :null => false
      t.datetime :ends_at, :null => false
      t.text :description, :null => true
      t.integer :status, :null => false, :default => 0
      t.boolean :private, :null => false, :default => true

      t.timestamps
    end
  end
end
