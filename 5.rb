rules, reports = ARGF.map(&:strip).reject(&:empty?).partition { | l | l.index("|") }

$rules_db = Hash.new { |h,k| h[k] = [] }
rules.each do | line |
  a, b = line.strip.split("|").map(&:to_i)
  $rules_db[a].push(b)
end

def compare(a, b)
  return -1 if $rules_db.include?(a) && $rules_db[a].include?(b)
  return 1 if !$rules_db.include?(b) || $rules_db[b].include?(a)
  0
end

reports.map! { | line | line.split(",").map(&:to_i) }
correct, incorrect = reports.partition do | report |
  report.each_cons(2).all? { | a, b | compare(b, a) != -1 }
end
incorrect.map! { _1.sort { | a, b | compare(b, a) } }

p [correct, incorrect].map { _1.sum { | r | r[r.length/2] } }
