class ChangeAuthenticationColumn < ActiveRecord::Migration
  def up
    remove_column :profiles, :authentication
    add_column    :profiles, :authentication_id, :integer
  end

  def down
  end
end
