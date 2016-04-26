module ApplicationHelper

  def flash_message
    if flash[:notice]
      display_message(flash[:notice],"notice")
    elsif flash[:alert]
      display_message(flash[:alert],"alert")
    end
  end

private

  def display_message(flash,type_class)
    content_tag :div, class: "message #{type_class}" do
      content_tag :p do
        flash
      end
    end
  end

end
