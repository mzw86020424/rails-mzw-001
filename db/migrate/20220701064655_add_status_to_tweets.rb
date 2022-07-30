class AddStatusToTweets < ActiveRecord::Migration[7.0]
  def change
    add_column :tweets, :status, :string
  end
end
