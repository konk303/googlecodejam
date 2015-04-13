#!/usr/bin/env ruby

require 'active_support'
require 'active_support/core_ext'
require 'pry'

class Serve

  attr_accessor :pancakes, :minutes

  def initialize(initial_diners_count, initial_pancakes_on_diner)
    _, @pancakes = initial_diners_count, initial_pancakes_on_diner
    pancakes.sort!
    @minutes = 0
    solve
  end

  private

  def solve
    while pancakes.any?
      # p pancakes, pancakes.count(pancakes.last)
      divide? ? move : eat
      self.minutes += 1
    end
  end

  def eat
    pancakes.map!{ |i| i - 1 if i > 1 }.compact!
  end

  def move
    div = pancakes.last / 2
    pancakes.pop
    pancakes.push div, div
    pancakes.sort!
  end

  def divide?
    pancakes.last.even? && (pancakes.count(pancakes.last) < pancakes.last / 2 || pancakes.count(pancakes.last) == pancakes.last / 2 && pancakes.count(pancakes.last - 1) == 0)
  end
end


T = ARGF.gets.to_i
T.times do |i|
  diners = ARGF.gets.to_i
  pancakes_on_diner = ARGF.gets.split(/\s/).map(&:to_i)
  puts "Case ##{i.succ}: #{Serve.new(diners, pancakes_on_diner).minutes}"
end
