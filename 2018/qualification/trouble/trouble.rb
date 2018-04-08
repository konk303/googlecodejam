#!/usr/bin/env ruby
class Trouble

  def initialize(l, a)
    @length = l
    @odds, @evens = [], []
    a.size.times do |i|
      if i.even?
        @odds << a.shift
      else
        @evens << a.shift
      end
    end
  end

  def result
    @odds.sort!
    @evens.sort!
    (@odds.size).times do |i|
      return i * 2 - 1 if i > 0 && @odds[i] < @evens[i - 1]
      return i * 2 if @evens[i] && @evens[i] < @odds[i]
    end
    'OK'
  end
end

T = gets.to_i
T.times do |t|
  l = gets.to_i
  a = gets.split(/\s/).map(&:to_i)
  puts "Case ##{t.succ}: #{Trouble.new(l, a).result}"
end
