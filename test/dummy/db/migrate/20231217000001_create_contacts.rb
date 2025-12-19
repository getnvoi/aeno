class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.text :bio
      t.string :company
      t.string :role
      t.string :location
      t.string :phone
      t.string :website

      t.timestamps
    end
  end
end
