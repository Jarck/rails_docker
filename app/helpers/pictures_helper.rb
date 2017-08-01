module PicturesHelper

  # URL拷贝
  def image_url_copy(picture)
    url = picture.image.blank? ? '' : picture.image[0].url

    url_copy_html = ''
    url_copy_html += '<div class="input-group">'
    url_copy_html +=     '<input id="picture' + picture.id.to_s + '" value="' + url + '" type="text" class="form-control"/>'
    url_copy_html +=     '<span class="input-group-btn">'
    url_copy_html +=     '<button class="btn" data-clipboard-target="#picture' + picture.id.to_s + '">'
    url_copy_html +=         '拷贝URL'
    url_copy_html +=     '</button>'
    url_copy_html +=      '</span>'
    url_copy_html += '</div>'

    return raw(url_copy_html)
  end

end