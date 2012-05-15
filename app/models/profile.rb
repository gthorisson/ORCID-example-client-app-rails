class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :authentication
  has_many :other_names, :dependent => :destroy
  
  validates :given_names,   :presence => true
  validates :family_name,   :presence => true
  validates :vocative_name, :presence => true


end
