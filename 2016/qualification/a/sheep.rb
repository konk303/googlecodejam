#!/usr/bin/env ruby

require 'active_support'
require 'active_support/core_ext'

CHARS = (0..9).map(&:to_s)

def solve(n)
  return 'INSOMNIA' if n.zero?

  chars = CHARS.dup
  i = 0
  result = nil
  while chars.any?
    i = i.succ
    result = n * i
    chars = chars - chars(result)
  end
  result
end

def chars(i)
  i.to_s.split(//)
end



T = ARGF.gets.to_i
T.times do |t|
  n = ARGF.gets.to_i
  puts "Case ##{t.succ}: #{solve n}"
end
