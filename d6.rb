#!/usr/bin/ruby
$fdat = File.read("d6.txt").strip.split(",").map &:to_i

def simulate(days)
  days.times do |i|
    adds = 0
    $fdat.map! do |n|
      if n == 0 then
        adds += 1
        next 6
      else
        next n-1
      end
    end
    adds.times { $fdat.push 8 }
    puts i if i%10==0
  end
end

simulate 80

puts $fdat.length

simulate 256-80

puts $fdat.length
