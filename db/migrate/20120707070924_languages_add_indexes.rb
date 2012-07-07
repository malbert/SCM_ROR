class LanguagesAddIndexes < ActiveRecord::Migration
  def up
    add_index :languages, [:name, :code]
  end

  def down
    remove_index :languages, [:name, :code]
  end
end
