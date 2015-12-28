class RemoveFileFromMicroposts < ActiveRecord::Migration
  def change
    remove_column :microposts, :file, :string
  end
end
