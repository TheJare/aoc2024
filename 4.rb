$input = ARGF.each.to_a
$w = $input[0].length
$h = $input.length

def at(x, y)
  (x < 0 || x >= $w || y < 0 || y >= $h)? "." : $input[y][x]
end

def word?(x, y, dx, dy, word)
  [word, word.reverse].any? {
    _1.chars.each_with_index.all? { | c, i | at(x + dx*i, y + dy*i) == c }
  }
end

directions = [[1,0],[1,1],[0,1],[-1,1]]

p Enumerator::product(0...$w, 0...$h, directions).count { |x, y, d| 
  word?(x, y, d[0], d[1], "XMAS")
}

def xword?(x, y, word)
  word?(x, y, 1, 1, word) && word?(x+word.length-1, y, -1, 1, word)
end

p Enumerator::product(0...$w, 0...$h).count { |x, y| 
  xword?(x, y, "MAS")
}
