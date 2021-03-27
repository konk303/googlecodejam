#!/usr/bin/env ruby

class Solve
  attr_accessor :result
  attr_reader :length

  def initialize(length, array)
      @length = length
      @array = array
      self.result = 0
  end

  def calc
    (1...length).to_a.each do |i|
      j = @array.index(i) + 1
      self.result += j
      @array = @array[0..(j - 1)].reverse.tap(&:shift) + @array[j..-1]
    end
  end
end

T = gets.to_i
T.times do |t|
  solve = Solve.new(gets.to_i, gets.split(' ').map(&:to_i))
  puts "Case ##{t.succ}: #{solve.tap(&:calc).result}"
end
