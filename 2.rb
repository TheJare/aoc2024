nums = ARGF.each.map { | l | l.split.map(&:to_i) }

def valid_report?(r)
  deltas = r.each_cons(2).map { | (a, b) | (a-b) }
  deltas.all? { _1.between?(1,3) } || deltas.all? { _1.between?(-3,-1) }
end

puts nums.filter { | r | valid_report?(r) } .count
puts nums.filter { | r | (0...r.length).any? { | i | valid_report?(r[0...i] + r[(i+1)..]) } } .count
