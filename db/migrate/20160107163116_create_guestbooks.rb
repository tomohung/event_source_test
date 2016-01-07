class CreateGuestbooks < ActiveRecord::Migration
  def change
    create_table :guestbooks do |t|
      t.string :name
      t.string :content

      t.timestamps null: false
    end
  end
end
