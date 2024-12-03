input = ARGF.read

puts input.scan(/mul\((\d+),(\d+)\)/).sum { | a, b | a.to_i * b.to_i }

enabled = true
puts input.scan(/do\(\)|don't\(\)|mul\(\d+,\d+\)/).sum { | x |
  if x =~ /mul\((\d+),(\d+)\)/
    enabled ? $1.to_i * $2.to_i : 0
  else
    enabled = x == "do()"
    0
  end
}
