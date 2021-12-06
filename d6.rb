#!/usr/bin/ruby
$fdat = File.read("d6.txt").strip.split(",").map &:to_i


$finct = 0
def simulate(days)
  # It is sufficient to know how many lanternfish are on a given stage.
  h = Hash.new(0)
  $fdat.each{ |el| h[el] += 1 }
  days.times do |i|
    handoffs = 0
    8.times do |stage|
      if stage == 0 then
        handoffs += h[stage]
      end
      h[stage], h[stage+1] = h[stage+1], h[stage]
    end
    h[6] += handoffs
  end
  return h.reduce(0) { |s, (_, v)| s += v }
end

puts simulate 80

puts simulate 256
