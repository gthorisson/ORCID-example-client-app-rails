class DropOrcidAndCidFromProfiles < ActiveRecord::Migration
  def up
    remove_column :profiles, :orcid
    remove_column :profiles, :cid
       
  end

  def down
  end
end
