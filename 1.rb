l, r = ARGF.each.map(&:split).transpose.map {|x| x.map(&:to_i).sort }
puts l.zip(r).sum { |a, b| (a-b).abs }
puts l.sum { |x| x*r.count(x) }
