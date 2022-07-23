class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships do |t|
      t.belongs_to :followee, foreign_key: { to_table: :users }
      t.belongs_to :follower, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
