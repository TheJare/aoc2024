machines = ARGF.each_slice(4).map do |machine|
  machine.map { _1.scan(/\d+/).map(&:to_i) } #take(3) not really needed
end

[0, 10000000000000].each do | prize_offset |
  p (machines.map do |(a, b, orgprize)|
    prize = [orgprize[0] + prize_offset, orgprize[1] + prize_offset]
    # solve the system of linear equations, assuming they are independent
    # accept only integral solutions
    nbn = a[1]*prize[0] - a[0]*prize[1]
    nbd = a[1]*b[0] - b[1]*a[0]
    if nbn % nbd == 0
      pb = nbn / nbd
      nan = prize[0] - b[0]*pb
      nad = a[0]
      if nan % nad == 0
        pa = nan / nad
        pa*3 + pb
      end
    end
  end).sum(&:to_i)
end
