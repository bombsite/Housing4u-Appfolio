module ApplicationHelper

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def tab(tab)
    content_for :tab, tab.to_s
  end

end
