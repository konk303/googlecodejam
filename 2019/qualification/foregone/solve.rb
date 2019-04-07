#!/usr/bin/env ruby
require 'logger'
require 'pry'

class Solve
  attr_reader :inputs, :firsts, :seconds
  def initialize(a)
    @inputs = a.split('')
    @firsts = []
    @seconds = []
    solve
  end

  def first
    firsts.join('').to_i
  end

  def second
    seconds.join('').to_i
  end

  private

  def solve
    inputs.each_with_index do |input, i|
      if input == '4'
        firsts[i] = '3'
        seconds[i] = '1'
      else
        firsts[i] = input
        seconds[i] = '0'
      end
    end
    # p inputs,firsts, seconds
  end
end

T = gets.to_i
T.times do |t|
  a = gets.chomp
  result = Solve.new(a)
  puts "Case ##{t.succ}: #{result.first} #{result.second}"
end
