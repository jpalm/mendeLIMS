# == Schema Information
#
# Table name: storage_positions
#
#  id                     :integer(4)      not null, primary key
#  row_nr                 :string(2)
#  position_nr            :string(3)       default(""), not null
#  storage_container_id   :integer(4)
#  sampleinv_id           :integer(4)
#  sampleinv_type         :integer(50)
#  sample_name_or_barcode :string(25)
#  notes                  :string(100)
#  created_at             :datetime
#  updated_by             :timestamp
#

class StoragePosition < ActiveRecord::Base
  belongs_to :storage_container
  belongs_to :sampleinv, :polymorphic => true 
end
