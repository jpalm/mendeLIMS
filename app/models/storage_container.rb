# == Schema Information
#
# Table name: storage_containers
#
#  id                  :integer(4)      not null, primary key
#  container_type      :string(4)
#  container_nr        :string(3)
#  project_name        :string(25)
#  container_descr     :string(25)
#  storage_location_id :integer(4)
#  notes               :string(255)
#  created_at          :datetime
#  updated_at          :timestamp
#

class StorageContainer < ActiveRecord::Base
  belongs_to :storage_location
  has_many :storage_positions 
  
  def container_string
    return [container_type, container_nr].join('-')
  end
end
