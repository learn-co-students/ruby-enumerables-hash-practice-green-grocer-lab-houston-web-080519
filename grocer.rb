def consolidate_cart(cart)
  consolidated_cart = Hash[cart.map { |k,v| [k,v] }]

consolidated_cart.group_by do |h| 
  h[:items] 
end.inject({}) do |h,(k,v)| 
  h.merge( { k => (v.map do |i| i[:price] end) } ) 
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
