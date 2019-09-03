def consolidate_cart(cart)
  con_cart = Hash.new
  
  cart.each { |item|
    product_name = item.keys[0]
    product_value = item.values[0]
  
    if con_cart.has_key?(product_name) then
      con_cart[product_name][:count] += 1
    else  
      con_cart[product_name] = product_value
      con_cart[product_name][:count] = 1
    end
  }
  
  print(con_cart)
  return con_cart
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
