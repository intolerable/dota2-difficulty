class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.belongs_to :winner
      t.belongs_to :loser
      t.string :mode

      t.timestamps
    end
  end
end
