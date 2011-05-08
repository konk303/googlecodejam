#!/usr/bin/env ruby

class CandySplitting
  def initialize(candies)
    @candies = candies
    @highest = 0
  end


  def try
    possibilities.each do |p|
      other = others(p)
      if patrics_sum(p) == patrics_sum(other)
        max = [sum(p), sum(other)].max
        if max > @highest
          @highest = max
        end
      end
    end
  end

  def result_string
    @highest.zero? ? "NO" : @highest
  end

  private

  def possibilities
    possibilities = []
    sizes_to_check.each do |s|
      possibilities += @candies.combination(s).to_a
    end
    possibilities
  end

  def sizes_to_check
    (1..((@candies.size - 1).to_f / 2).ceil).to_a
  end

  def others(ours)
    #     @candies.reject{|i| ours.include?(i) }
    other = @candies.clone
    ours.each do |o|
      other.delete_at(other.index(o))
    end
    other
  end

  def patrics_sum(target)
    target.inject(&:^)
  end

  def sum(target)
    target.inject(&:+)
  end
end

T = ARGF.gets.to_i
T.times do |i|
  n = ARGF.gets.to_i
  candies = ARGF.gets.split(/\s/).map(&:to_i)

  candy_splitting = CandySplitting.new(candies)
  candy_splitting.try
  puts "Case ##{i.succ}: #{candy_splitting.result_string}"
end
