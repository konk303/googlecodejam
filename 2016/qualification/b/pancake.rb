#!/usr/bin/env ruby

require 'active_support'
require 'active_support/core_ext'
require 'pry'

class Pancake
  attr_reader :count

  def initialize(flags)
    @stack = flags.split(//).map{ |s| s == '+' }
    find_min_count!
  end

  private

  def find_min_count!
    @count = 0
    while true
      pop_resolved_from_stack
      break if @stack.size.zero?
      flip(point_to_flip)
      @count = @count.succ
    end
  end

  def pop_resolved_from_stack
    first_pop = @stack.rindex(false)&.succ
    if first_pop
      # not all true
      if first_pop != @stack.size
        # last is not false
        @stack[first_pop..@stack.size] = []
      end
    else
      # all true
      @stack = []
    end
  end

  def point_to_flip
    if @stack.first
      @stack.index(false)
    else
      @stack.size
    end
  end

  def flip(n)
    @stack[0, n] = @stack[0, n].reverse.map(&:!)
  end
end


T = ARGF.gets.to_i
T.times do |t|
  flags = ARGF.gets.chomp
  puts "Case ##{t.succ}: #{Pancake.new(flags).count}"
end
