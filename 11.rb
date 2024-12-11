stone_lines = ARGF.map { _1.split.map(&:to_i)}

def evolve_stone(v)
  return [1] if v == 0
  vs = v.to_s
  l = vs.length
  return [vs[...l/2].to_i, vs[l/2..].to_i] if l % 2 == 0
  [v*2024]
end

Enumerator.product(stone_lines, [25, 75]) do |stones, blinks|
  coll = Hash.new { |h,k| h[k] = 0 }
  stones.each { coll[_1] += 1 }
  (1..blinks).each do
    co2 = Hash.new { |h,k| h[k] = 0 }
    coll.each do |(v, n)|
      nv = evolve_stone(v)
      nv.each { |v| co2[v] += n }
    end
    coll = co2
  end
  p coll. sum { _1[1] }
end
