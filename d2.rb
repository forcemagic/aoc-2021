#!/usr/bin/ruby
fdat = File.read("d2.txt").split "\n"
hor = 0
dep = 0
fdat.each do |d|
  spl = d.split
  if spl[0] == "forward" then
    hor += spl[1].to_i
  elsif spl[0] == "up" then
    dep -= spl[1].to_i
  elsif spl[0] == "down" then
    dep += spl[1].to_i
  end
end
puts "H: #{hor}, D: #{dep}"
puts hor * dep

aim = 0
hor = 0
dep = 0
fdat.each do |d|
  spl = d.split
  if spl[0] == "forward" then
    hor += spl[1].to_i
    dep += aim * spl[1].to_i
  elsif spl[0] == "up" then
    aim -= spl[1].to_i
  elsif spl[0] == "down" then
    aim += spl[1].to_i
  end
end
puts "A: #{aim}, H: #{hor}, D: #{dep}"
puts hor * dep
