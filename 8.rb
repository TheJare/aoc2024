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
    return false if x < 0 || x >= $w || y < 0 || y >= $h
    antinodes.add([x, y])
    true
  end

  $towers.values.each do | freq_positions |
    freq_positions.permutation(2).each do | (x1, y1), (x2, y2) |
      dx = x2 - x1
      dy = y2 - y1
      range.take_while { | i | try_add_antinode.(x1 + i*dx, y1 + i*dy) }
    end
  end
  antinodes.length
end

p find_antinodes [2]
p find_antinodes 1.. # laziest thing ever

# Enumerator.product(0...$h, 0...$w) do | y, x |
#   print antinodes.member?([x,y])? "#" : "."
#   puts if x == $w-1
# end

