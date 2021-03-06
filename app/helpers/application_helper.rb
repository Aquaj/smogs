module ApplicationHelper
  def icon_tag(icon_name, style=:regular, html_options={})
    style_classes = { regular: 'far',
                      solid: 'fas',
                      light: 'fal',
                      duotone: 'fad' }
    classes = []
    classes << style_classes[style]
    classes << "fa-#{icon_name}"
    classes << html_options[:class].to_s
    content_tag :i, nil, class: classes, **html_options.except(:class)
  end

  def header(&block)
    if block_given?
      content_for :header, &block
    else
      if content_for :header
        content_for :header
      else
        content_tag :h2, "Sans titre ?"
      end
    end
  end
end
