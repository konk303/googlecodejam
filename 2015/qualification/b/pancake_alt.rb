#!/usr/bin/env ruby

require 'active_support'
require 'active_support/core_ext'
require 'pry'

def solve(initial_diners_count, pancakes)
  p [initial_diners_count, pancakes]
  (1..pancakes.max).inject(pancakes.max) do |fastest, i|
    tot = i
    pancakes.each { |p| tot += (p.to_f / i).ceil - 1 if p > i }
    [fastest, tot].tap{|a| p a}.min
  end
end

T = ARGF.gets.to_i
T.times do |i|
  diners = ARGF.gets.to_i
  pancakes_on_diner = ARGF.gets.split(/\s/).map(&:to_i)
  puts "Case ##{i.succ}: #{solve(diners, pancakes_on_diner)}"
end
