$input = ARGF.each.to_a
$w = $input[0].length
$h = $input.length

$obstacles = Set.new
$pos = [0,0]

Enumerator.product(0...$w, 0...$h) do | x, y |
  if $input[y][x] == "#"
    $obstacles.add([x,y])
  elsif $input[y][x] == "^"
    $pos = [x,y]
  end
end

$directions = [[0,-1],[1,0],[0,1],[-1,0]]

def bot(obstacles, x, y, d)
  loop do
    yield(x, y, d)
    while obstacles.include?([x+$directions[d][0], y+$directions[d][1]])
      d = (d + 1) % 4
    end
    x += $directions[d][0]
    y += $directions[d][1]
    return false if x < 0 || x >= $w || y < 0 || y >= $h
  end
end

visited = Set.new
bot($obstacles, $pos[0], $pos[1], 0) { | x, y, d | visited.add([x,y])}
p visited.length

# very brutal force
p visited.select(&->(p) {
  dvisited = Set.new
  p != $pos && bot($obstacles.dup.add(p), $pos[0], $pos[1], 0) { | x, y, d |
    return true if dvisited.include?([x,y,d])
    dvisited.add([x,y,d])
  }
}).length
