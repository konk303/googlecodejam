#!/usr/bin/env ruby

class Contestants
  attr_reader :total_value
  def initialize(number, *values)
    @number = number
    @total_value = values.sum
    @contestants = []
    @number.times do |i|
      @contestants.push(Contestant.new(values[i], self))
    end
  end

  def minimum_percentages
    @contestants.map(&:minimum_percentage).map(&:to_s).join(" ")
  end
end

class Contestant
  def initialize(value, contestants)
    @value = value
    @total_point = contestants.total_value
  end

  def minimum_percentage
    0.1
  end
end

  # def smallest_expected
  #   expecteds = []
  #   length.succ.times do |i|
  #     expecteds.push expected(i)
  #   end
  #   expecteds.push(giving_up)
  #   expecteds.min
  # end

  # def giving_up
  #   @enter + @length + @enter
  # end

  # def expected(times)
  #   results = []

  #   cases.each do |hoge|
  #     results.push(probability[times] * storke_needed(times))
  #   end
  #   results.sum
  #   end

  # def probability
  # end

  # def storke_needed(times)
  #   @backspace * times + (@length - (@typed - times)) + @enter
  # end

  # def qualified
  #   qualified_without_surprise = @points.select{|i|
  #     i >= min_point_to_qualify_without_surprise}.count
  #   qualified_only_with_surprise = @points.select{ |i|
  #     i >= min_point_to_qualify_with_surprise && i < min_point_to_qualify_without_surprise
  #   }.count
  #   qualified_with_surprise = [qualified_only_with_surprise, @surprises].min
  #   # p qualified_without_surprise, qualified_only_with_surprise, qualified_with_surprise
  #   qualified_without_surprise + qualified_with_surprise
  # end

  # private

  # def min_point_to_qualify_with_surprise
  #   @min_point_to_qualify_with_surprise ||=
  #     [@limit * 3 - 4, 2].max
  # end

  # def min_point_to_qualify_without_surprise
  #   @min_point_to_qualify_without_surprise ||=
  #     [@limit * 3 - 2, 0].max
  # end

T = ARGF.gets.to_i
T.times do |i|
  cases = ARGF.gets.split(/\s/).map(&:to_i)
  contestants = Contestants.new(*cases)
  puts "Case ##{i.succ}: #{contestants.minimum_percentages}"
end
