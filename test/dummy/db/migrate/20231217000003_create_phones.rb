class CreatePhones < ActiveRecord::Migration[8.0]
  def change
    create_table :phones do |t|
      t.references :sibling, null: false, foreign_key: true
      t.string :number
      t.string :phone_type

      t.timestamps
    end
  end
end
