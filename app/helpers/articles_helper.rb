module ArticlesHelper
  def image_field(form)
    tag.div class: "form-group" do
      concat form.label :image
      concat (tag.div class: "file-field-container"  do
        form.file_field :image, accept: ".jpeg,.jpg,.png,.gif", id:'uploading-image', class: 'image-field'
      end)
    end
  end
end
