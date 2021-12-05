#!/usr/bin/ruby
fdat = File.read("d4.txt").split "\n"
draws = fdat.shift.split(",").map(&:to_i)
boards = []
tb = []
fdat.shift
fdat.each do |rl|
  if rl == '' then
    boards.push tb
    tb = []
    next
  end
  tb.push rl.split(/\s+/).map(&:to_i)
end

drawn = []
winscore = 0
catch :winfound do
  draws.each do |dr|
    drawn.push dr
    boards.each do |board|
      tbrd = board.reduce(&:zip).map(&:flatten) # can't .transpose non-square matrix
      rows = board.map{ |r| r.map{ |n| drawn.include?(n) ? 1 : 0 }.sum }
      cols = tbrd.map{ |r| r.map{ |n| drawn.include?(n) ? 1 : 0 }.sum }
      if rows.include? board[0].length or cols.include? tbrd[0].length then
        winscore = board.flatten.map{ |n| drawn.include?(n) ? 0 : n }.sum * dr
        throw :winfound
      end
    end
  end
end

puts winscore

drawn = []
winctr = 0
lastscore = 0
draws.each do |dr|
  drawn.push dr
  boards.each_with_index do |board, i|
    tbrd = board.reduce(&:zip).map(&:flatten) # can't .transpose non-square matrix
    rows = board.map{ |r| r.map{ |n| drawn.include?(n) ? 1 : 0 }.sum }
    cols = tbrd.map{ |r| r.map{ |n| drawn.include?(n) ? 1 : 0 }.sum }
    if rows.include? board[0].length or cols.include? tbrd[0].length then
      winctr += 1
      lastscore = board.flatten.map{ |n| drawn.include?(n) ? 0 : n }.sum * dr
      boards.delete_at i
    end
  end
  break if winctr == boards.length
end

puts lastscore

