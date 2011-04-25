class FlowcellQueriesController < ApplicationController
  authorize_resource :class => FlowCell
  
  before_filter :dropdowns, :only => :new_query
  
  def new_query
    @flowcell_query = FlowcellQuery.new(:from_date => (Date.today - 6.months).beginning_of_month,
                                        :to_date   =>  Date.today)
  end
 
  def index
    @flowcell_query = FlowcellQuery.new(params[:flowcell_query])
    
    if @flowcell_query.valid?
      @condition_array = define_conditions(params)
      @hdr = 'Sequencing Runs (Filtered)'
      @flow_cells = FlowCell.find_sequencing_runs(@condition_array)
      if @flow_cells.size == 1 
        @flow_cell = @flow_cells[0]
        redirect_to :controller => 'flow_cells', :action => :show, :id => @flow_cell.id
      else
        render :action => :index
      end
      
    else
      dropdowns
      render :action => :new_query
    end
  end

protected
  def dropdowns
    @sequencers       = SeqMachine.sequencers.find(:all)  
  end
  
  def define_conditions(params)
    @where_select = []
    @where_values = []
    
    if !params[:flowcell_query][:run_nr].blank?
      sql_where_clause = ["flow_cells.seq_run_nr = ?", params[:flowcell_query][:run_nr].to_i]
      
    else
      if !param_blank?(params[:flowcell_query][:machine_name])
        @where_select.push("flow_cells.sequencing_key LIKE ?")
        @where_values.push('%' + params[:flowcell_query][:machine_name] + '%')
      end
      
      date_fld = 'flow_cells.sequencing_date'
      @where_select, @where_values = sql_conditions_for_date_range(@where_select, @where_values, params[:flowcell_query], date_fld)
      sql_where_clause = (@where_select.length == 0 ? [] : [@where_select.join(' AND ')].concat(@where_values))
    end
    
    return sql_where_clause
  end
  
end