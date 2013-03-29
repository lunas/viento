module AnalysisHelper

  def cell_link(cell_text, row_index, col_index, table, analyzed_by)
    if cell_text.to_i > 0
      link_to cell_text, filter_sales_path(search_params_hash(table, row_index, col_index, analyzed_by))
    else
      cell_text
    end
  end

  def search_params_hash(table, row_index, col_index, analyzed_by)
    {"name" => table[row_index].first,
     analyzed_by.to_sym => table.first[col_index]
    }
  end

end
