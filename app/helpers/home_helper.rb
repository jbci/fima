module HomeHelper
  def number_to_spans(number)
    number.to_s.split("").map{|i| '<span class="counter"> ' + i + '</span>'}.join.html_safe
  end
end
