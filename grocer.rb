def consolidate_cart(cart)
  cart.reduce({}) do |memo, item|
    if memo.include? item.keys[0]
      memo[item.keys[0]][:count] += 1
    else
      item.values[0][:count] = 1
      memo[item.keys[0]] = item.values[0]
    end

    memo
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart.include?(item) && cart[item][:count] >= coupon[:num]
      cart[item + ' W/COUPON'] = {
        price: coupon[:cost] / coupon[:num],
        clearance: cart[item][:clearance],
        count: coupon[:num] * (cart[item][:count] / coupon[:num])
      }
      cart[item][:count] %= coupon[:num]
    end
  end

  cart
end

def apply_clearance(cart)
  cart.each_value do |item|
    item[:price] = (item[:price] * 0.8).round(2) if item[:clearance]
  end
end

def checkout(cart, coupons)
  total = apply_clearance(apply_coupons(consolidate_cart(cart), coupons)).reduce(0) do |memo, (_key, value)|
    memo += value[:price] * value[:count]

    memo
  end

  total > 100 ? total * 0.9 : total
end