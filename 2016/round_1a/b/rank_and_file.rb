#!/usr/bin/env ruby

require 'active_support'
require 'active_support/core_ext'
require 'pry'

class RankAndFile
  attr_accessor :grid, :missing

  def initialize(size, lists)
    @list = lists.sort
    @grid = Array.new(size) { Array.new(size) }
    binding.pry
    grid[0] = @list.shift
    # set first c
    @rc = false
    @target_index = 0
    set_r_or_c

    @target_index = 1
    @list.size.times do
      set_r_or_c
      @target_index = @target_index.succ if @rc
      @rc = !@rc
    end
    unless missing
      # last r is missing
      @missing = [true, size - 1]
    end
  end

  def set_r_or_c
    @list.first.each_with_index do |i, index|
      target = if @rc
                 grid[@target_index][index]
               else
                 grid[index][@target_index]
               end
      if target.nil?
        if @rc
          grid[@target_index][index] = i
        else
          grid[index][@target_index] = i
        end
      elsif target != i
        # found missing
        @missing = [@rc, @target_index]
        return
      end
    end
    @list.shift
  end

  def result
    answer = if missing.first
               grid[missing.last]
             else
               grid.map { |a| a[missing.last] }
             end
    answer.join(' ')
  end
end

T = ARGF.gets.to_i
T.times do |t|
  n = ARGF.gets.to_i
  lists = (2 * n - 1).times.each_with_object([]) do |_, a|
    a << ARGF.gets.split.map(&:to_i)
  end
  puts "Case ##{t.succ}: #{RankAndFile.new(n, lists).result}"
end
