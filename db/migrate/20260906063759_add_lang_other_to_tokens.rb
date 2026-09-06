class AddLangOtherToTokens < ActiveRecord::Migration[8.1]
  def change
    add_column :tokens, :lang_other, :boolean
  end
end
