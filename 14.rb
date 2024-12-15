robots = ARGF.each.map { _1.scan(/-?\d+/).map(&:to_i)}
$w, $h = [101, 103]

def compute(robots, nsteps)
  final = robots.map { |(x,y,dx,dy)| [(x + nsteps*dx) % $w, (y + nsteps*dy) % $h] }
  Enumerator.product((0..1), (0..1)).map do |(qx, qy)|
    x0 = qx*($w/2+1)
    x1 = x0+($w/2)
    y0 = qy*($h/2+1)
    y1 = y0+($h/2)
    v = final.count { |(x,y)| x >= x0 && x < x1 && y >= y0 && y < y1 }
    v
  end
end
p compute(robots, 100).reduce(&:*)

p "answer for part 2 is <<censored>>" # I hate these puzzles
