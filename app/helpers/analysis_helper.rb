module AnalysisHelper

  def cell_link(cell, row_index, col_index, table, analyzed_by)
    if cell.nil?
      cell
    elsif cell.first == 0
      "0/#{cell.second}"
    else
      l = link_to cell.first.to_s, filter_sales_path(search_params_hash(table, row_index, col_index, analyzed_by))
      l + "/#{cell.second}"
    end
  end

  def search_params_hash(table, row_index, col_index, analyzed_by)
    hash = {"name" => table[row_index].first,
      analyzed_by.to_sym => table.first[col_index]
    }
    if params[:analysis]
      hash[:collection] = params[:analysis][:collection] if params[:analysis][:collection].present?
      hash[:date_from]  = params[:analysis][:date_from]  if params[:analysis][:date_from]
      hash[:date_to]    = params[:analysis][:date_to]    if params[:analysis][:date_to]
    end
    hash
  end

end
