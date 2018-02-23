class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :tid, index: true, unique: true, null: false
      t.text :text, null: false
      t.string :url, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
