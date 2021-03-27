#!/usr/bin/env ruby

class Solver
  attr_reader :cj, :jc, :row

  def initialize(cj, jc, row)
    @cj = cj
    @jc = jc
    @row = row.delete('?')
  end

  def result
    cj * row.scan('CJ').size + jc * row.scan('JC').size
  end
end

T = gets.to_i
T.times do |t|
  cj, jc, row = gets.chomp.split(' ')
  puts "Case ##{t.succ}: #{Solver.new(cj.to_i, jc.to_i, row).result}"
end
