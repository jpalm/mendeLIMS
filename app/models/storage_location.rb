# == Schema Information
#
# Table name: storage_locations
#
#  id          :integer(4)      not null, primary key
#  room_nr     :string(25)      default(""), not null
#  freezer_nr  :string(25)
#  owner_name  :string(25)
#  owner_email :string(50)
#  comments    :string(255)
#  created_at  :datetime
#  updated_at  :timestamp       not null
#

class StorageLocation < ActiveRecord::Base
  #has_many :samples
  #has_many :processed_samples
  
  #validates_uniqueness_of :location_string
  has_many :storage_containers
  
  def location_string
    name_array      = owner_name.split(' ')
    last_nm         = (owner_name.nil? ? ' ' : name_array[-1])
    last_nm_wparens = (last_nm.blank? ? ' ' : ['(', last_nm, ')'].join)
    return [[room_nr, freezer_nr].join('/'), last_nm_wparens].join
  end
  
  def self.list_all_by_room
    self.find(:all, :order => 'storage_locations.room_nr, storage_locations.freezer_nr')
  end
end
