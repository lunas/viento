module AnalysisHelper

  def cell_link(cell_text, row_index, col_index, table, analyzed_by)
    if cell_text.to_i > 0
      link_to cell_text, filter_sales_path(search_params_hash(table, row_index, col_index, analyzed_by))
    else
      cell_text
    end
  end

  def search_params_hash(table, row_index, col_index, analyzed_by)
    hash = {"name" => table[row_index].first,
      analyzed_by.to_sym => table.first[col_index]
    }
    if params[:analysis]
      hash[:collection] = params[:analysis][:collection] if params[:analysis][:collection]
      hash[:date_from]  = params[:analysis][:date_from]  if params[:analysis][:date_from]
      hash[:date_to]    = params[:analysis][:date_to]    if params[:analysis][:date_to]
    end
    hash
  end

end
