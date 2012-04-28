class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :other_names, :dependent => :destroy
  
  validates :firstname, :presence => true
  validates :lastname,  :presence => true


end
