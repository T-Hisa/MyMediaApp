module ApplicationHelper

  def header_link(text, path)
    class_name = 'nav-link'
    class_name << ' disable active' if current_page?(path)
    
    link_to text, path, class: class_name
  end
end
