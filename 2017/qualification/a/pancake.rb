#!/usr/bin/env ruby

require 'active_support'
require 'active_support/core_ext'
require 'pry'

class Pancake
  attr_reader :result

  def initialize(flags, k)
    @row = flags.split(//).map{ |s| s == '+' }
    @k = k.to_i
    @result = 0
    get_result!
  end

  private

  def get_result!
    (@row.size - @k + 1).times do |i|
      unless @row[i]
        flip_at(i)
        @result += 1
      end
      return if @row.all?
    end
    @result = 'IMPOSSIBLE'
  end

  def flip_at(pos)
    @k.times do |i|
      @row[pos + i] = !@row[pos + i]
    end
  end
end

T = ARGF.gets.to_i
T.times do |t|
  flags, k = ARGF.gets.split(/\s/)
  puts "Case ##{t.succ}: #{Pancake.new(flags, k).result}"
end
