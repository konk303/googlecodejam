#!/usr/bin/env ruby

require 'active_support'
require 'active_support/core_ext'
require 'pry'

class Bathroom
  attr_reader :max, :min

  def initialize(n, k)
    @n, @k = n, k
    @stalls = [true, true]
    @n.times { |i| @stalls[i.succ, 0] = false }
    @k.times { |i| get_stall i }
  end

  private

  def get_stall(person)
    maxes, mins = [], []
    @stalls.each_with_index do |stall, i|
      next if stall
      ls = 0
      pos = i.pred
      while true
        break if @stalls[pos]
        ls += 1
        pos -= 1
      end
      rs = 0
      pos = i.succ
      while true
        break if @stalls[pos]
        rs += 1
        pos += 1
      end
      mins[i] = [ls, rs].min
      maxes[i] = [ls, rs].max
    end
    selected = nil
    max_mins = mins.compact.max
    max_maxes = maxes.compact.max
    if max_mins > 0 && mins.count(max_mins) == 1
      selected = mins.index(max_mins)
    elsif maxes.count(max_maxes) == 1
      selected = maxes.index(max_maxes)
    elsif max_mins > 0
      selected = mins.index(max_mins)
    else
      selected = maxes.index(max_maxes)
    end
    @stalls[selected] = person
    @max = maxes[selected]
    @min = mins[selected]
    # p [selected, @max, @min, max_maxes, max_mins]
    # p [selected, @stalls, max_mins, mins, max_maxes, maxes]
  end
end

T = ARGF.gets.to_i
T.times do |t|
  n, k = ARGF.gets.split(/\s/).map(&:to_i)
  bathroom = Bathroom.new(n, k)
  puts "Case ##{t.succ}: #{bathroom.max} #{bathroom.min}"
end
