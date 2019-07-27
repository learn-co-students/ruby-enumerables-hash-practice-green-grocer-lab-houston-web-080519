def consolidate_cart(cart)
  hashcart = {}
  cart.each do |item|
    name = item.keys[0]
    hashcart[name] = item.values[0]
    
    if hashcart[name][:count]
      hashcart[name][:count] += 1
    else
      hashcart[name][:count] = 1
    end
  end
  hashcart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        item_w_coupon = "#{coupon[:item]} W/COUPON"
        if cart[item_w_coupon]
          cart[item_w_coupon][:count] += coupon[:num]
        else
        cart[item_w_coupon] = {
          price: coupon[:cost]/coupon[:num],
          clearance: cart[coupon[:item]][:clearance],
          count: coupon[:num]
          }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end


def apply_clearance(cart)
  cart.each do |name, data|
    if data[:clearance]
      data[:price] = (data[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  consol = consolidate_cart(cart)
  coupond = apply_coupons(consol, coupons)
  cleard = apply_clearance(coupond)
  total = 0
  cleard.keys.each do |item|
    total += (cleard[item][:price] * cleard[item][:count])
  end
  
  if total > 100
    total * 0.9
  else
    total
  end
end
