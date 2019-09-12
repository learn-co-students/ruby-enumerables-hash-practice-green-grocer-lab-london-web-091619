require 'pry'

def consolidate_cart(cart)
  final_hash = {}
  cart.each {|element_hash|
  element_name = element_hash.keys[0]
  element_stats = element_hash.values[0]
  
  if final_hash.has_key?(element_name)
     element_stats[:count] +=1
  else
    element_stats[:count] =1
    final_hash[element_name] = element_stats
  end
}
  final_hash
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
  cart.each{|product_name, stats|
  stats[:price] -= stats[:price] * 0.2 if stats[:clearance]
  }
  cart
end

def checkout(array, coupons)
  hash_cart = consolidate_cart(array)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_discount = apply_clearance(applied_coupons)
  total = applied_discount.reduce(0){|acc, (key,value)| acc += value[:price] * value[:count]}
  if total > 100
    total *= 0.9
  end
  total
end


