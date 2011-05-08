#!/usr/bin/env ruby

class Scalar
  attr_reader :result


  def initialize(v1, v2)
    @v1, @v2 = v1, v2
    @result = nil
  end


  def find_smallest
    @v1.sort!
    @v2.sort!.reverse!
    @result = total(@v1, @v2)
#     @v1.permutation.each do |v1|
#       @v2.permutation.each do |v2|
#         result = total(v1, v2)
#         if @result == nil or  result < @result
#           @result = result
#         end
#       end
#     end
  end

  private

  def total(v1, v2)
    v1.zip(v2).map{|v| v.inject(&:*)}.inject(&:+)
  end

end

T = ARGF.gets.to_i
T.times do |i|
  n = ARGF.gets.to_i
  v1 = ARGF.gets.split(/\s/).map(&:to_i).take(n)
  v2 = ARGF.gets.split(/\s/).map(&:to_i).take(n)
  scalar = Scalar.new(v1, v2)
  scalar.find_smallest
  puts "Case ##{i.succ}: #{scalar.result}"
end
