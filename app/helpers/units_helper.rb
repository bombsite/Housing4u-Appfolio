module UnitsHelper

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def tab(tab)
    content_for :tab, tab.to_s
  end


  def total_found(units)
    (units.respond_to? :total) ? "Found <em>#{units.total}</em> results, showing <em>#{units.count}</em>".html_safe : "Found <em>#{units.count}</em> results.".html_safe
  end

  def replace_search_param(original_params, name, value)
    local_params = original_params.dup
    local_params[:search] ||= {}
    local_params[:search] = local_params[:search].dup
    local_params[:search][name] = value

    local_params
  end

  def original_search(params)
    params[:search] && params[:search][:q]
  end

end
