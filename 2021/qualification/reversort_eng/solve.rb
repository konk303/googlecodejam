#!/usr/bin/env ruby

class Solver
  attr_accessor :ret
  attr_reader :size, :cost, :min_cost, :max_cost

  def initialize(size, cost)
    @size = size
    @cost = cost
    @min_cost = size - 1
    @max_cost = (size + 2) * (size - 1) / 2
    @ret = Array.new(size)
  end

  def result
    return 'IMPOSSIBLE' if cost < min_cost
    return 'IMPOSSIBLE' if cost > max_cost

    lr = :l
    1.upto(size).reduce(cost) do |remaining, value|
      reverse_cost = size - value + 1
      # p [remaining, value, reverse_cost]
      if remaining - (size - value) + 1 >= reverse_cost
        lr = lr == :l ? :r : :l
        remaining -= reverse_cost
      else
        remaining -= 1
      end
      lr == :l ? to_l(value) : to_r(value)
      remaining
    end

    ret.join(' ')
  end

  private

  def to_l(value)
    ret[ret.index(nil)] = value
  end

  def to_r(value)
    -1.downto(-size).each do |index|
      if ret[index].nil?
        ret[index] = value
        return
      end
    end
  end
end

T = gets.to_i
T.times do |t|
  size, cost = gets.chomp.split(' ').map(&:to_i)
  solver = Solver.new(size, cost)
  puts "Case ##{t.succ}: #{solver.result}"
end
