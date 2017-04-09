#!/usr/bin/env ruby

require 'active_support'
require 'active_support/core_ext'
require 'pry'

class TidyNumbers
  attr_reader :last_tidy_number

  def initialize(n)
    @n = n
    @last_tidy_number = @n
    get_last_tidy_number!
  end

  private

  def get_last_tidy_number!
    while true
      return if tidy?
      set_next_last_tidy_number!
    end
  end

  def tidy?
    @splitted = @last_tidy_number.to_s.split(//).map(&:to_i)
    return true if @splitted.size == 1
    return true if @splitted.each_cons(2).with_index.all? do |(s1, s2), i|
      @pos = i
      s1 <= s2
    end
  end

  def set_next_last_tidy_number!
    if @splitted[@pos] > 1
      @splitted[@pos] = @splitted[@pos] - 1
      (@splitted.size - @pos.succ).times { |i| @splitted[@pos.succ + i] = 9 }
    elsif @pos == 0
      @splitted[@pos] = nil
      (@splitted.size - @pos.succ).times { |i| @splitted[@pos.succ + i] = 9 }
    else
      @splitted[@pos.pred] = @splitted[@pos.pred] - 1
      (@splitted.size - @pos.succ).times { |i| @splitted[@pos.succ + i] = 9 }
    end
    @last_tidy_number = @splitted.join.to_i
  end
end

T = ARGF.gets.to_i
T.times do |t|
  n = ARGF.gets.to_i
  puts "Case ##{t.succ}: #{TidyNumbers.new(n).last_tidy_number}"
end
