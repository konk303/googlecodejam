#!/usr/bin/env ruby
# require 'pry'

class Solve
  attr_reader :strings

  def initialize(string)
    @strings = string.split('').map(&:to_i)
  end

  def result
    (strings + [0]).inject([0]) do |result, i|
      prev = result.last
      diff = i - prev
      if diff.positive?
        diff.times { result << '(' }
      else
        (-diff).times { result << ')' }
      end
      result.tap { |result| result << i }
    end.tap(&:shift).tap(&:pop).join('')
  end
end

T = gets.to_i
T.times do |t|
  solver = Solve.new(gets.chomp)
  puts "Case ##{t.succ}: #{solver.result}"
end
