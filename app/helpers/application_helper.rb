module ApplicationHelper

  def header_link(text, path ,flag)
    class_name = flag ? 'dropdown-item custom-dropdown' : 'nav-link'
    # 開かれているページがリンク先の対象ページの場合、class名に追加する。
    class_name << ' active' if current_page?(path)
    
    link_to text, path, class: class_name
  end

  def error_text_include?(text)
    flash[:error].to_s.include?(text) if flash[:error].present?
  end
end
