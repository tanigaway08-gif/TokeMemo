class AddUserRefToTokens < ActiveRecord::Migration[8.1]
  def change
    add_reference :tokens, :user, null: false, foreign_key: true
  end
end
