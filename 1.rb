l1, l2 = ARGF.each.map(&:split).transpose.map {|x| x.map(&:to_i).sort }
puts l1.zip(l2).sum { |a, b| (a-b).abs }
puts l1.sum { |x| x*l2.count(x) }
