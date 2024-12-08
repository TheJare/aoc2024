$input = ARGF.map(&:strip).to_a
$w = $input[0].length
$h = $input.length

$towers = Hash.new { |h,k| h[k] = [] }

Enumerator.product(0...$w, 0...$h) do | x, y |
  c = $input[y][x]
  if c != "." && c != "#"
    $towers[c].push([x,y])
  end
end

def find_antinodes(range)
  antinodes = Set.new
  try_add_antinode = -> (x, y) do
    antinodes.add([x, y]) if x >= 0 && x < $w && y >= 0 && y < $h
  end

  $towers.values.each do | freq_positions |
    freq_positions.permutation(2).each do | p1, p2 |
      dx = p1[0] - p2[0]
      dy = p1[1] - p2[1]
      range.each { | i | try_add_antinode.(p1[0]+i*dx, p1[1]+i*dy) }
    end
  end
  antinodes.length
end

p find_antinodes [-2, 1]
retries = [$w-1, $h-1].max
p find_antinodes (-retries..retries)

# Enumerator.product(0...$h, 0...$w) do | y, x |
#   print $antinodes.member?([x,y])? "#" : "."
#   puts if x == $w-1
# end

