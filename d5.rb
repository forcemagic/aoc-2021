#!/usr/bin/ruby
fdat = File.read("d5.txt").split "\n"

lines = fdat.map{|ln| ln.split(" -> ").map{|coords| coords.split(",").map(&:to_i) }}

pts = []
diag = []
lines.each do |ln|
  if ln[0][0] == ln[1][0] then
    (ln[0][1]..ln[1][1]).step(ln[0][1]<ln[1][1] ? 1 : -1).each do |i|
      pts.push [ln[0][0], i]
    end
  elsif ln[0][1] == ln[1][1] then
    (ln[0][0]..ln[1][0]).step(ln[0][0]<ln[1][0] ? 1 : -1).each do |i|
      pts.push [i, ln[0][1]]
    end
  else
    puts "Deferring diagonal line: #{ln[0]} -> #{ln[1]}"
    diag.push ln
  end
end

cts = pts.each_with_object(Hash.new 0) do |pt, h|
  h["#{pt[0]}-#{pt[1]}"] += 1
end

cts.delete_if {|k,v| v <= 1}
puts "#{cts.size}"

diag.each do |ln|
  if (ln[0][0]-ln[1][0]).abs != (ln[0][1]-ln[1][1]).abs then # actually not needed
    puts "Illegal diagonal: #{ln[0]} -> #{ln[1]}"
    next
  end
  odir = ln[0][1] < ln[1][1] ? 1 : -1
  ev = ln[1][0]-ln[0][0]
  (0..ev).step((ln[0][0]<ln[1][0]) ? 1 : -1).each do |i|
    pts.push [ln[0][0]+i, ln[0][1]+(i.abs*odir)]
  end
end

cts = pts.each_with_object(Hash.new 0) do |pt, h|
  h["#{pt[0]}-#{pt[1]}"] += 1
end

cts.delete_if {|k,v| v <= 1}
puts "#{cts.size}"

