input = ARGF.first.chars.map(&:to_i)
fsys = input.flat_map.with_index do |n,i|
  id = (i % 2 == 0)? i/2 : -1
  [id]*n
end

i = fsys.index(-1)
l = fsys.rindex { _1 != -1 }                
if i != nil && l != nil
  while i < l
    if fsys[i] != -1
      i += 1
    elsif fsys[l] == -1
      l -= 1
    else
      fsys[i] = fsys[l]
      fsys[l] = -1
    end
  end
end
p fsys[...i].each_with_index.sum { |id, i| id*i }

# part 2
AocFile = Struct.new(:index, :len, :id)
AocHole = Struct.new(:index, :len)
files = []
holes = []
input.each_with_index.reduce(0) do |index, (n, i)|
  if n > 0
    if i % 2 == 0
      files.push(AocFile.new(index, n, i/2))
    else
      holes.push(AocHole.new(index, n))
    end
  end
  index + n
end

nfile = files.length - 1
while nfile >= 0 && holes.length > 0
  file = files[nfile]
  ih = holes.index { |h| break if h.index >= file.index; h.len >= file.len }
  if ih != nil
    hole = holes[ih]
    files.slice!(nfile)
    files.push(AocFile.new(hole.index, file.len, file.id))
    if hole.len == file.len
      holes.slice!(ih) # hole was filled up completely
    else
      holes[ih] = AocHole.new(hole.index + file.len, hole.len - file.len)
    end
    # we never bother tracking / coalescing the hole where the file used to reside
    # since by the rules of the problem we'll never try to fill it up
  end
  nfile -= 1
end

p files.sum { |file| file.id*(file.index*2 + file.len-1)*file.len/2 } 
