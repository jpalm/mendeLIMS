# == Schema Information
#
# Table name: sample_storage_containers
#
#  id                     :integer(4)      not null, primary key
#  stored_sample_id       :integer(4)
#  stored_sample_type     :string(50)
#  sample_name_or_barcode :string(25)      default(""), not null
#  container_type         :string(10)
#  container_name         :string(25)      default(""), not null
#  position_in_container  :string(15)
#  freezer_location_id    :integer(4)
#  storage_container_id   :integer(4)
#  row_nr                 :string(2)
#  position_nr            :string(3)       default("")
#  notes                  :string(100)
#  updated_by             :timestamp
#

class SampleStorageContainer < ActiveRecord::Base
  belongs_to :freezer_location
  belongs_to :stored_sample, :polymorphic => true
  
  def before_create
    self.sample_name_or_barcode = self.stored_sample.barcode_key
  end
  
  def container_desc
    [container_type, container_name].join(': ')
  end
  
  def container_and_position
    [container_desc, position_in_container].join('/')
  end
  
  def room_and_freezer
    (freezer_location ? freezer_location.room_and_freezer : '')
  end
  
  def self.populate_dropdown
    self.find(:all, :select => 'DISTINCT container_type', :order => 'container_type')
  end
end
