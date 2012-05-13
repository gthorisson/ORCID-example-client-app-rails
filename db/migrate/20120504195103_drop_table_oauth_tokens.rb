class DropTableOauthTokens < ActiveRecord::Migration
  def up 
    drop_table :client_applications
    drop_table :comments
    drop_table :posts
    drop_table :tags
    drop_table :oauth_nonces
  end

  def down
  end
end
