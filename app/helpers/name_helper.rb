module NameHelper
  def auto_name_field(form)
    parent_class_name = 'form-group'
    parent_class_name << ' user-edit-form' if @current_user && current_page?(edit_user_path(@current_user))
    class_name = 'form-control'
    class_name << ' border-danger' if error_text_include?("ユーザー")
    
    tag.div class: parent_class_name do
      concat form.label :name, 'ユーザー名'
      concat @current_user.present? ?
      (form.text_field :name, value: @current_user.name, class: class_name, id: "name_field") :
      (form.text_field :name, class: class_name)
    end
  end
  
  def auto_name_field_for_edit(form)
    class_name = 'form-control'
    class_name << ' border-danger' if error_text_include?("ユーザー")
    
    tag.div class: 'form-group user-edit-form' do
      concat form.label :name, 'ユーザー名'
      concat form.text_field :name, value: @current_user.name, class: class_name, id: "name"
    end
  end
end