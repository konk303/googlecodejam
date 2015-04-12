#!/usr/bin/env ruby

# require 'active_support'
# require 'active_support/core_ext'
require 'pry'

class Omino

  attr_reader :x, :grid_count, :rc

  def initialize(x, r, c)
    @x, r, c = x, r, c
    @rc = [r, c].sort
    @grid_count = r * c
  end

  def won_by
    p [x, grid_count, rc, fillable?, all_placable?]
    fillable? && all_placable? ? 'GABRIEL' : 'RICHARD'
  end

  private

  def fillable?
    grid_count % x == 0
  end

  def all_placable?
    (1..(x / 2 + x % 2)).map{ |s| placable?(s) }.all? { |f| f }
  end

  def placable?(s)
    rc[0] >= s && rc[1] >= (x - s + 1)
  end
end

T = ARGF.gets.to_i
T.times do |i|
  x, r, c = ARGF.gets.split(/\s/).map(&:to_i)
  puts "Case ##{i.succ}: #{Omino.new(x, r, c).won_by}"
end
