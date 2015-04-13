#!/usr/bin/env ruby

require 'active_support'
require 'active_support/core_ext'

def solve(max_level, counts_per_level)
  # p max_level
  # p counts_per_level
  (1..max_level).inject(0) do |fill, level|
    below = fill + counts_per_level.take(level).sum
    counts_per_level[level] > 0 && level > below ? fill + (level - below) : fill
  end
end

T = ARGF.gets.to_i
T.times do |i|
  max, levels = ARGF.gets.split(/\s/)
  puts "Case ##{i.succ}: #{solve(max.to_i, levels.split(//).map(&:to_i))}"
end
