#!/usr/bin/env ruby

class TypePassword
  def initialize(typed, length, probabilities)
    @typed, @length, @probabilities = typed, length, probabilities
    @enter = @backspace = 1
  end

  def smallest_expected
    expecteds = []
    length.succ.times do |i|
      expecteds.push expected(i)
    end
    expecteds.push(giving_up)
    expecteds.min
  end

  def giving_up
    @enter + @length + @enter
  end

  def expected(times)
    results = []

    cases.each do |hoge|
      results.push(probability[times] * storke_needed(times))
    end
    results.sum
    end

  def probability
  end

  def storke_needed(times)
    @backspace * times + (@length - (@typed - times)) + @enter
  end

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

end

T = ARGF.gets.to_i
T.times do |i|
  a, b = ARGF.gets.split(/\s/).map(&:to_i)
  ps = ARGF.gets.split(/\s/).map(&:to_f)
  type_password = TypePassword.new(a, b, ps)
  puts "Case ##{i.succ}: #{type_password.smallest_expected}"
end
