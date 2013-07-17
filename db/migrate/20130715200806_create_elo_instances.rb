class CreateEloInstances < ActiveRecord::Migration
  def change
    create_table :elo_instances do |t|
      t.integer :rating
      t.integer :games
      t.boolean :pro

      t.timestamps
    end
  end
end
