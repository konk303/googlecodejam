#!/usr/bin/env ruby

class Scores
  def initialize(dancers, surprises, limit, points)
    @dancers, @surprises, @limit, @points = dancers, surprises, limit, points
  end

  def qualified
    qualified_without_surprise = @points.select{|i|
      i >= min_point_to_qualify_without_surprise}.count
    qualified_only_with_surprise = @points.select{ |i|
      i >= min_point_to_qualify_with_surprise && i < min_point_to_qualify_without_surprise
    }.count
    qualified_with_surprise = [qualified_only_with_surprise, @surprises].min
    # p qualified_without_surprise, qualified_only_with_surprise, qualified_with_surprise
    qualified_without_surprise + qualified_with_surprise
  end

  private

  def min_point_to_qualify_with_surprise
    @min_point_to_qualify_with_surprise ||=
      [@limit * 3 - 4, 2].max
  end

  def min_point_to_qualify_without_surprise
    @min_point_to_qualify_without_surprise ||=
      [@limit * 3 - 2, 0].max
  end

end

T = ARGF.gets.to_i
T.times do |i|
  inputs = ARGF.gets.split(/\s/)
  n = inputs.shift.to_i
  s = inputs.shift.to_i
  p = inputs.shift.to_i
  scores = Scores.new(n, s, p, inputs.map(&:to_i))
  puts "Case ##{i.succ}: #{scores.qualified}"
end
