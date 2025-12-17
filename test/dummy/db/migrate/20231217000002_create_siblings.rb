class CreateSiblings < ActiveRecord::Migration[8.0]
  def change
    create_table :siblings do |t|
      t.references :contact, null: false, foreign_key: true
      t.string :name
      t.string :age

      t.timestamps
    end
  end
end
