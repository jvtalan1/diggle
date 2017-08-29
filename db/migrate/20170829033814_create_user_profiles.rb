class CreateUserProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_profiles do |t|
      t.string :username, unique: true
      t.string :full_name
      t.string :phone_number
      t.string :location
      t.string :picture

      t.timestamps
      t.index :username, unique: true
      t.belongs_to :user
    end

    remove_column :users, :full_name, :string
    remove_column :users, :username, :string
    remove_column :users, :phone_number, :string
    remove_column :users, :location, :string
    remove_column :users, :picture, :string
  end
end
