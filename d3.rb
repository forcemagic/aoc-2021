#!/usr/bin/ruby
fdat = File.read("d3.txt").split "\n"

mtrx = fdat.map {|d| d.chars.map(&:to_i)}
omtrx = mtrx
mtrx = mtrx.transpose()

gamma = []
eps = []
mtrx.each_with_index do |vec, i|
  if vec.count(1)>vec.count(0) then
    gamma[i] = 1
    eps[i] = 0
  else
    gamma[i] = 0
    eps[i] = 1 
  end
end

def btoi(arr)
  return arr.reverse.map.with_index{ |d, i| d * 2**i }.sum
end

puts "G: #{btoi(gamma)}, E: #{btoi(eps)}"
puts btoi(gamma)*btoi(eps)

comtrx = omtrx
(0..omtrx.length).each do |n|
  cm = omtrx.transpose
  crow = cm[n]
  if crow.count(1)>crow.count(0) or crow.count(1)==crow.count(0) then
    omtrx = omtrx.filter{ |m| m[n] == 1 }
  else
    omtrx = omtrx.filter{ |m| m[n] == 0 }
  end
  break if omtrx.length == 1
end

(0..comtrx.length).each do |n|
  cm = comtrx.transpose
  crow = cm[n]
  if crow.count(1)>crow.count(0) or crow.count(1)==crow.count(0) then
    comtrx = comtrx.filter{ |m| m[n] == 0 }
  else
    comtrx = comtrx.filter{ |m| m[n] == 1 }
  end
  break if comtrx.length == 1
end

oxy = btoi(omtrx[0])
co2 = btoi(comtrx[0])

puts "O2: #{oxy}, CO2: #{co2}"
puts oxy * co2

