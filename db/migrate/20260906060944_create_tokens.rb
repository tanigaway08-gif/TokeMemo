class CreateTokens < ActiveRecord::Migration[8.1]
  def change
    create_table :tokens do |t|
      t.string :code
      t.text :translation
      t.text :example
      t.text :memo
      t.boolean :lang_html
      t.boolean :lang_css
      t.boolean :lang_javascript
      t.boolean :lang_ruby
      t.boolean :lang_rails

      t.timestamps
    end
  end
end
