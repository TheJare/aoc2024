$input = ARGF.each.to_a
$w = $input[0].length
$h = $input.length

def at(x, y)
  (x < 0 || x >= $w || y < 0 || y >= $h)? "." : $input[y][x]
end

directions = [[1,0],[0,1],[-1,0],[0,-1]]

trailheads = []
Enumerator::product(0...$w, 0...$h).each do |x, y| 
  c = at(x, y)
  if c == "0"
    trailheads.push([x,y,c.ord+1])
  end
end

score = 0
p trailheads.sum { |p|
  trails = [p]
  peaks_found = Set.new
  while trails.length > 0
    x, y, c = trails.pop
    if at(x,y) == "9"
      peaks_found.add([x,y])
      score += 1
    else
      directions.each { |(dx, dy)| trails.push([x+dx, y+dy, c+1]) if at(x+dx, y+dy).ord == c }
    end
  end
  peaks_found.length
}
p score
