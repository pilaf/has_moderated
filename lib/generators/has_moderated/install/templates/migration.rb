class CreateModerations < ActiveRecord::Migration
  def self.up
    if table_exists? :moderations # for upgrading
      Moderation.all.each { |m| m.accept }
      drop_table :moderations
    end
    create_table "moderations" do |t|
      t.integer "moderatable_id",  :null => true
      t.string  "moderatable_type",  :null => true
      t.string  "attr_name",    :limit => 60,  :null => false
      t.text    "attr_value",  :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :moderations
  end
end
