#!/usr/bin/ruby
$fdat = File.read("d8.txt").split("\n").map{|v| v.split(" | ").map{|s| s.split(" ")}}

nums = [2,4,3,7] # 1,4,7,8
ctr = 0
$fdat.each do |fd|
  fd[1].each do |dig|
    if nums.include? dig.length then
      ctr += 1
    end
  end
end

puts ctr

# Monkeypatching :DD
class Array
  def extract!(&block)
    ta = self.select &block
    self.reject! &block
    ta
  end
end

# 0,6 1,2 2,5 3,5 4,4 5,5 6,6 7,3 8,7 9,6
res = []
coll = 0
$fdat.each do |fd|
  res[8] = fd[0].extract!{ |d| d.length == 7 }[0]
  res[7] = fd[0].extract!{ |d| d.length == 3 }[0]
  res[4] = fd[0].extract!{ |d| d.length == 4 }[0]
  res[1] = fd[0].extract!{ |d| d.length == 2 }[0]
  res[3] = fd[0].extract!{ |d| (d.chars & res[1].chars).length == 2 && d.length == 5 }[0]
  res[6] = fd[0].extract!{ |d| d.length == 6 && (d.chars & res[1].chars).length == 1 }[0]
  res[5] = fd[0].extract!{ |d| (d.chars & res[6].chars).length == 5 && d.length == 5 }[0]
  res[9] = fd[0].extract!{ |d| (d.chars & res[5].chars).length == 5 && d.length == 6 }[0]
  res[2] = fd[0].extract!{ |d| (d.chars - res[3].chars).length == 1}[0]
  res[0] = fd[0].pop
  res.map!{|r| r.chars.sort.join}

  coll += fd[1].map{|d| res.index(d.chars.sort.join)}.join().to_i
end

puts coll
