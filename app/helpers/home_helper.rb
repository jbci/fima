module HomeHelper
  def number_to_spans(number)
    number.to_s.split("").map{|i| '<span class="counter"> ' + i + '</span>'}.join.html_safe
    # content_tag :div, class: "" do
    #   number.to_s.split("").collect {|i| content_tag :span, i, class: "counter" }
    # end
  end
end
