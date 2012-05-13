class AddOrcidFieldsToProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :firstname
    remove_column :profiles, :lastname
    remove_column :profiles, :middleinitials

    add_column :profiles, :family_name,   :string,  :limit => 500
    add_column :profiles, :given_names,   :string,  :limit => 500
    add_column :profiles, :vocative_name, :string,  :limit => 500
    add_column :profiles, :credit_name,   :string,  :limit => 500
    
  end
end
