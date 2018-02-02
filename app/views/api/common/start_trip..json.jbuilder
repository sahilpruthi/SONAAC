<%binding.pry%>

json.products @driver_fairs do |product|
  json.name product.name
  json.price number_to_currency product.price
  json.active product.active
end