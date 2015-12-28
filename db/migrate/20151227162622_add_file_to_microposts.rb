class AddFileToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :file, :string
  end
end
