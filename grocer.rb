def consolidate_cart(cart)
  new_cart = {}
  cart.each_with_index { |item|
    item.each{ |item_name, info|
      if new_cart[item_name]
        new_cart[item_name][:count] += 1
      else
        new_cart[item_name] = info
        new_cart[item_name][:count] = 1
      end
}}
new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_name = coupon[:item]
    new_cart = "#{item_name} W/COUPON"
    coupon_number = coupon[:num]
    coupon_cost = coupon[:cost]
    
    if cart[item_name] && cart[item_name][:count] >= coupon_number
      cart[item_name][:count] -= coupon_number
      if cart[new_cart]
        cart[new_cart][:count] += coupon_number
      else 
        cart[new_cart] = {
        :price => coupon_cost/coupon_number,
        :clearance => cart[item_name][:clearance],
        :count => coupon_number
      }
      end 
    end
  end 
  cart
end 




def apply_clearance(cart)
  new_cart = cart
  cart.each {|item, info|
  if info[:clearance]==true
    new_cart[item][:price] = (cart[item][:price] *0.80).round(2)
  end
  }
  new_cart
end

def checkout(cart, coupons)
  total = 0
  combined_cart = consolidate_cart(cart)
  combined_coupons = apply_coupons(combined_cart, coupon)
  clearing_cart = apply_clearance(combined_coupons)
  
  clearing_cart.each{ |item, info|
  total += info[:price] * info[:count]
  }
  
  if total > 100
    total = total * 0.9
  end
  total
end