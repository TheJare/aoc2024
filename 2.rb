nums = ARGF.each.map { | l | l.split.map(&:to_i) }

def valid_report(r)
  d = r.each_cons(2).map { | (a, b) | (a-b) }
  d.all? { _1.between?(1,3) } || d.all? { _1.between?(-3,-1)}
end

puts nums.filter { | l | valid_report(l) } .count
puts nums.filter { | l | (0...l.length).any? { | i | valid_report(l[0...i] + l[(i+1)..]) } } .count
