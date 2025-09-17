module ApplicationHelper

  def button_icon(icon_class, text=nil)
    content_tag(:span, class: 'badge bg-light text-dark') do
      content_tag(:i, class: icon_class) do
        text
      end
    end
  end

end
