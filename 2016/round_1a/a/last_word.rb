#!/usr/bin/env ruby

require 'active_support'
require 'active_support/core_ext'

def solve(words)
  current_first = words.shift
  result = [current_first]
  words.each_with_object(result) do |s, a|
    if s < current_first
      a << s
    else
      current_first = s
      a.unshift s
    end
  end
end

T = ARGF.gets.to_i
T.times do |t|
  a = ARGF.gets.chomp.split(//)
  puts "Case ##{t.succ}: #{solve(a).join('')}"
end
