def consolidate_cart(cart)
    cart.each_with_object({}) do |item, new_cart|
        k, v = item.first
        new_cart.key?(k) ? new_cart[k][:count] += 1 : new_cart[k] = v.merge(count: 1)
    end
end

# def consolidate_coupons(coupons)
#   coupons.group_by { |obj| obj[:item] }.map do |key, value|
#     num_sum = value.sum { |i| i[:num] }
#     cost_sum = value.sum { |i| i[:cost] }
#     Hash[:item, key, :num, num_sum, :cost, cost_sum]
#   end
# end

def apply_coupons(cart, coupons)
  return cart if coupons.count < 1
  discounted_cart = {}
  cart.each_key do |key|
    discounted_cart[key] = cart.delete(key) if !coupons.find { |coupon| coupon[:item] == key}
    coupons.each do |coupon|
      if key == coupon[:item]
        discounted_name = "#{key} W/COUPON"
        coupon_value = coupon[:cost] / coupon[:num]
        if coupon[:num] > cart[key][:count]
          cart[key][:count] = 0
          discounted_cart[discounted_name] = {:price => coupon_value, :clearance => cart[key][:clearance], :count => coupon[:num]}
end

def apply_coupons(cart, coupons)
  return cart if coupons.count < 1
  discounted_cart = {}
  cart.each_key do |key|
    discounted_cart[key] = cart.delete(key) if !coupons.find { |coupon| coupon[:item] == key}
    coupons.each do |coupon|
      if key == coupon[:item]
        discounted_name = "#{key} W/COUPON"
        coupon_value = coupon[:cost] / coupon[:num]
        if coupon[:num] >= cart[key][:count]
          discounted_cart[discounted_name] = {:price => coupon_value, :clearance => cart[key][:clearance], :count => cart[key][:count]}
          cart[key][:count] = 0
          discounted_cart[key] = cart[key]
        elsif coupon[:num] < cart[key][:count]
          discounted_cart[discounted_name] = {:price => coupon_value, :clearance => cart[key][:clearance], :count => coupon[:num]}
          cart[key][:count] -= coupon[:num]
          discounted_cart[key] = cart[key]
        end
      end
    end
  end
  discounted_cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
