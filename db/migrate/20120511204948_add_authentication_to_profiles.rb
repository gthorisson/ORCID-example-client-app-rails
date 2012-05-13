class AddAuthenticationToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :authentication, :integer    
  end
end
