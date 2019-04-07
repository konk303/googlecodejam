#!/usr/bin/env ruby
require 'logger'

STDOUT.sync = true

class Solve
  attr_accessor :challenging, :challenged, :returned, :slice_size
  attr_reader :n, :b, :f, :workers, :brokens

  def initialize(n, b, f)
    @n = n
    @b = b
    @f = f

    @logger = Logger.new('log.txt')

    @slice_size = (n % b).zero? ? (n / b) : (n / b).succ
    @workers = Array.new(n)
    @brokens = []
    @challenging = []
    @returned = []
    @challenged = 0
  end

  def communicate_until_finish
    while true
      plan
      send!
      receive!
      analyze
      if finished?
        finish!
        return
      end
    end
  end

  private

  def plan
    @challenging = workers.each_slice(slice_size).with_index.map do |group, i|
      Array.new(group.size) { i.odd? ? '1' : '0' }
    end
  end

  def analyze

  end

  def send!
    @logger.debug ['send', challenging]
    puts challenging.flatten.join('')
    challenged += 1
  end

  def finish!
    @logger.debug ['send', brokens]
    puts brokens.join(' ')
    response = gets.to_i
    @logger.debug ['receive', response]
 end

  def receive!
    @returned = gets.split(//)
    @logger.debug ['receive', returned]
  end

  def finished?
    brokens.size == b
  end
end

T = gets.to_i
T.times do |t|
  n, b, f = gets(chomp: true).split(' ').map(&:to_i)
  Solve.new(n, b, f).communicate_until_finish
end
