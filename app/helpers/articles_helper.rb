module ArticlesHelper
  def image_field(form)
    tag.div class: "form-group" do
      concat form.label :image, '添付する画像'
      concat (tag.div class: "file-field-container"  do
        form.file_field :image, id:'uploading-image', class: 'image-field'
      end)
    end
  end
end
