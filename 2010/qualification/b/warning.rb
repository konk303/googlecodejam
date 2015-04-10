#!/usr/bin/env ruby

def fair_warning(count, events)
  diffs = events.combination(2).map{ |a| a.max - a.min }
  # p diffs
  total_gcd = diffs.inject(diffs.min){ |gcd, i| i.gcd(gcd) }
  # p total_gcd
  mod = events.min % total_gcd
  mod == 0 ? 0 : total_gcd - mod
end

T = ARGF.gets.to_i
T.times do |i|
  events = ARGF.gets.split(/\s/).map(&:to_i)
  count = events.shift
  puts "Case ##{i.succ}: #{fair_warning(count, events)}"
end
