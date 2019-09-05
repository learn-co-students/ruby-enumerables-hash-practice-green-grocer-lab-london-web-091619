def consolidate_cart(cart)
  # code here
  carthash = {}
  cart.each do |e|
    title = e.keys[0]
    if carthash.keys.include?(title)
      carthash[title][:count] +=1
else
carthash.merge!(e)
carthash[title].merge!({:count => 1})
    end
  end
  carthash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |e|
    count = e[:num]
    price = e[:cost] / count
    item = e[:item]
    couponitem = item + " W/COUPON"

    if cart[item] && cart[item][:count] >= count
      cart[item][:count] -= count
    if cart.keys.include?(couponitem)
      cart[couponitem][:count] += count
    else
    cart.merge!(couponitem => {:price => price, :clearance => cart[item][:clearance], :count => count})
  end
  end
end
cart
end


def apply_clearance(cart)
  # code here
  cart.keys.map do |e|
    if cart[e][:clearance]
      cart[e][:price] = ((cart[e][:price] * 0.80).round(2))
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  consolidated_cart = apply_coupons(consolidated_cart, coupons)
  consolidated_cart = apply_clearance(consolidated_cart)
  total = 0
  consolidated_cart.keys.collect do |e|
    total += consolidated_cart[e][:price] * consolidated_cart[e][:count]
  end

  if total>100
total = (total*0.9).round(2)
  end

  total
end
