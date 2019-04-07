#!/usr/bin/env ruby
require 'logger'
require 'pry'

class Solve
  attr_reader :size, :lydia
  def initialize(size, lydia)
    @size = size
    @lydia = lydia.split('')
  end

  def ownway
    lydia.map { |s| s == 'E' ? 'S' : 'E' }.join('')
  end
end

T = gets.to_i
T.times do |t|
  size = gets.to_i
  lydia = gets.chomp
  puts "Case ##{t.succ}: #{Solve.new(size, lydia).ownway}"
end
