class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile, :string
    add_column :users, :location, :string
    add_column :users, :age, :integer
    add_column :users, :birthday, :integer
  end
end
