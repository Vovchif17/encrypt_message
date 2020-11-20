class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :text
      t.string :uuid
      t.boolean :viewed
      t.string :password_digest

      t.timestamps
    end
  end
end
