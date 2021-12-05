fdat = File.read("d1.txt").split.map(&:to_i)
prev = fdat[0]
ctr = 0
fdat.each do |d|
  ctr += d>prev ? 1 : 0
  prev = d
end
puts ctr

prev = fdat[0..2].sum
ctr = 0
fdat.each_with_index do |d, i|
  if i+2 >= fdat.length then next end
  s = fdat[i..i+2].sum
  ctr += s>prev ? 1 : 0
  prev = s
end
puts ctr

