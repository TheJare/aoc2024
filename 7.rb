input = ARGF.map { | l | l.strip.split(/:? /).map(&:to_i)}.to_a

# brute force galore
def sum_valid_equations(input, operators)
    input.filter { | eq |
    operators.repeated_permutation(eq.length - 2).any? do | p |
      eq[0] == p.zip(eq[2..]).reduce(eq[1]) {| a, (op, b) | op.call(a, b) }
    end
  }. sum { | eq | eq[0]}
end

p sum_valid_equations(input, [:*.to_proc, :+.to_proc])
p sum_valid_equations(input, [:*.to_proc, :+.to_proc, -> (a,b) {[a,b].join.to_i }])
