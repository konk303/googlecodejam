#!/usr/bin/env ruby

require 'active_support'
require 'active_support/core_ext'
require 'pry'

class Fractile
  def initialize(k, c, s)
    @k, @c, @s = k, c, s
    @result = []
    build_sequence_possibilities!
    build_possibilities!
    find_solution!
  end

  def result
    @result.present? ? @result.join(' ') : 'IMPOSSIBLE'
  end

  private

  def build_sequence_possibilities!
    @originals = [true, false].repeated_permutation(@k)
  end

  def build_possibilities!
    @possibilities = @originals.map { |original| result_from_original(original) }
  end

  def find_solution!
    # all fail is the last possibilities
    others = @possibilities.dup.tap(&:pop)
    (@k ** @c).times do |i|
      falses = others.select { |a| !a[i] }
      if falses.size.zero?
        # resolved
        @result = [i.succ]
        return
      elsif falses.size < @s
        # resolvable
        @result = [i.succ] + falses.map { |a|
          a.index(true).succ
        }.uniq
        return
      end
    end
  end

  def result_from_original(original)
    original.dup.tap do |tiles|
      @c.pred.times do
        tiles.map! { |t|
          if t
            Array.new(@k, t)
          else
            original.dup
          end
        }.flatten!
      end
    end
  end
end

T = ARGF.gets.to_i
T.times do |t|
  k, c, s = ARGF.gets.split(/\s/).map(&:to_i)
  puts "Case ##{t.succ}: #{Fractile.new(k, c, s).result}"
end
