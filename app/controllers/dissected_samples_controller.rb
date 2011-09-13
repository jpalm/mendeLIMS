class DissectedSamplesController < ApplicationController
  
  before_filter :dropdowns, :only => :edit
  
  def new_params  
  end
  
  # GET /dissected_samples/new
  def new
    authorize! :create, Sample
    
    if params[:source_sample_id]
      @source_sample = Sample.find(params[:source_sample_id], :include => :histology)
    else
      @source_sample = Sample.find_by_barcode_key(params[:barcode_key], :include => :histology)
    end
    
    if !@source_sample.nil?
      prepare_for_render_new(@source_sample.id)
      sample_params = build_params_from_obj(@source_sample, Sample::SOURCE_FLDS_FOR_COPY)
      sample_params.merge!(:barcode_key      => @sample_barcode,
                           :source_sample_id => @source_sample.id,
                           :source_barcode_key => @source_sample.barcode_key,
                           :amount_uom       => 'Weight (mg)',
                           :sample_date      => Date.today)
      @sample = Sample.new(sample_params)  
    else
      flash[:error] = 'Sample barcode not found, please try again'
      redirect_to :action => 'new_params'
    end
  end
  
  def edit
    @sample = Sample.find(params[:id])
    @source_sample = Sample.find(@sample.source_sample_id, :include => :sample_characteristic)
    @storage_location = StorageLocation.find(@sample.storage_location_id) if !@sample.storage_location_id.nil?
  end
  
  def update
    @sample        = Sample.find(params[:id])
    @source_sample = Sample.find(@sample.source_sample_id)
    
    if @sample.update_attributes(params[:sample])
      @source_sample.update_attributes(:sample_remaining => params[:source_sample][:sample_remaining]) if params[:source_sample]
      flash[:notice] = 'Sample was successfully updated'
      redirect_to(@sample)
    else
      flash[:error] = 'Error updating sample'
      redirect_to :action => 'edit'
    end
  end
  
  # POST /dissected_samples
  def create
    authorize! :create, Sample
    
    params[:sample].merge!(:amount_rem => params[:sample][:amount_initial].to_f)
    @sample        = Sample.new(params[:sample])
    @source_sample = Sample.find(params[:sample][:source_sample_id])

    if @sample.save
      @source_sample.update_attributes(:sample_remaining => params[:source_sample][:sample_remaining]) if params[:source_sample]
      flash[:notice] = 'Sample successfully created'
      redirect_to samples_list1_path(:source_sample_id => params[:sample][:source_sample_id], :add_new => 'yes')
    else
      prepare_for_render_new(params[:sample][:source_sample_id])
      render :action => "new" 
    end
  end
  
protected
  def prepare_for_render_new(source_sample_id)
    # Find source sample, and sample characteristic associated with new (dissected) sample
    @source_sample    = Sample.find_by_id(source_sample_id)
    @sample_characteristic = SampleCharacteristic.find_by_id(@source_sample.sample_characteristic_id)
    
    # Determine next increment number for barcode suffix
    @sample_barcode = Sample.next_dissection_barcode(source_sample_id, @source_sample.barcode_key)
    
    # populate drop-down lists
    dropdowns
  end
  
  def dropdowns
    @category_dropdowns = Category.populate_dropdowns([Cgroup::CGROUPS['Sample']])
    @tumor_normal       = category_filter(@category_dropdowns, 'tumor_normal')
    @amount_uom         = category_filter(@category_dropdowns, 'unit of measure') 
    @storage_locations  = StorageLocation.list_all_by_room
  end
  
end
