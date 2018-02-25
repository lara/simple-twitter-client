class AddUniqueConstraintToTweetId < ActiveRecord::Migration[5.1]
  def change
    remove_index :tweets, :tid
    add_index :tweets, :tid, unique: true
  end
end
