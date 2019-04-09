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

  def create_tree(array, divide_by)
    per_one = array.size / (divide_by + ((array.size % divide_by).nonzero? ? 1 : 0))
    array.eac_slice(per_one)
  end

  def plan
    @challenging = workers.each_slice(slice_size).with_index.map do |group, i|
      Array.new(group.size) { i.odd? ? '1' : '0' }
    end
  end

  def analyze

  end

  def finish!
    @logger.debug ['send', brokens]
    puts brokens.join(' ')
    response = gets.to_i
    @logger.debug ['receive', response]
 end

  def finished?
    brokens.size == b
  end

  class Communicator
    attr_reader :limit, :logger

    def initialize(limit)
      @limit = limit
      @logger = Logger.new('log.txt')
      @count = 0
    end

    def communicate(array)
      send!(array)
    end

    private

    def send!(string)
      raise 'limit reached' if @count == limit
      logger.debug ['send', string]
      puts array.flatten.join('')
      @count += 1
    end

    def receive!
      gets.tap do |returned|
        logger.debug ['receive', returned]
        raise '-1 returned' if returned == '-1'
      end
    end
  end
end

T = gets.to_i
T.times do |t|
  n, b, f = gets(chomp: true).split(' ').map(&:to_i)
  Solve.new(n, b, f).communicate_until_finish
end
