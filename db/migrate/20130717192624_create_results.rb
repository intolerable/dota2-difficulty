class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :winner, index: true
      t.references :loser, index: true
      t.string :mode

      t.timestamps
    end
  end
end
