class IndexTagsController < ApplicationController
  
  def index
    @adapters = IndexTag.find(:all, :select => "runtype_adapter, COUNT(id)", :group => "runtype_adapter")
    index_tags = IndexTag.find(:all, :order => "tag_nr, runtype_adapter")
    @index_tags = index_tags.group_by {|tag| tag.tag_nr}
  end

end
