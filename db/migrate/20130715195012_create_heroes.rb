class CreateHeroes < ActiveRecord::Migration
  def change
    create_table :heroes do |t|
      t.string :name
      t.string :slug
      t.belongs_to :upper
      t.belongs_to :lower

      t.timestamps
    end
  end
end
