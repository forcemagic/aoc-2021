#!/usr/bin/ruby
$fdat = File.read("d7.txt").strip.split(",").map &:to_i

a = $fdat.max

endl = []
(1..a).each do |n|
  endl.push [n, $fdat.map{|fd| (fd-n).abs}.sum]
end

puts "#{endl.sort_by{|o| o[1]}[0][1]}"

endl = []
(1..a).each do |n|
  endl.push [n, $fdat.map do |fd|
    x = (fd-n).abs
    next x*(x+1)/2
  end.sum]
end

puts "#{endl.sort_by{|o| o[1]}[0][1]}"
