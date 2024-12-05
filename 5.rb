$rules, $reports = ARGF.reduce([Hash.new { |h,k| h[k] = []}, []]) { | (rules, reports), line |
  rule = line.strip!.split("|")
  if rule.length == 2
    rules[rule[0].to_i].push(rule[1].to_i)
  elsif rule.length != 0
    reports.push(line.split(",").map(&:to_i))
  end
  [rules, reports]
}

def compare(a, b)
  return -1 if $rules.include?(a) && $rules[a].include?(b)
  return 1 if !$rules.include?(b) || $rules[b].include?(a)
  0
end

correct, incorrect = $reports.reduce([[],[]]) { | (correct, incorrect), report |
  if report.each_cons(2).all? { | a, b | compare(b, a) != -1 }
    correct.push(report)
  else
    incorrect.push(report.sort { | a, b | compare(b, a) })
  end
  [correct, incorrect]
}

p [correct, incorrect].map { _1.sum { | r | p r; r[r.length/2] } }
