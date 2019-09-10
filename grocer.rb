def consolidate_cart(cart)
  hash = {}
  cart.each do |item|
    if hash[item.keys[0]]
      hash[item.keys[0]][:count] += 1
    else
      hash[item.keys[0]] = {
        count: 1,
        price: item.values[0][:price],
        clearance: item.values[0][:clearance]
      }
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_cart = "#{coupon[:item]} W/COUPON"
        if cart[new_cart]
          cart[new_cart][:count] += coupon[:num]
        else
          cart[new_cart] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |k, v|
    if v[:clearance]
      v[:price] = (v[:price] * 0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated = consolidate_cart(cart)
  coupons = apply_coupons(consolidated, coupons)
  discounts = apply_clearance(coupons)

  total = 0.0
  discounts.keys.each do |item|
    total += discounts[item][:price]*discounts[item][:count]
  end
  total > 100.00 ? (total * 0.90).round : total
end
