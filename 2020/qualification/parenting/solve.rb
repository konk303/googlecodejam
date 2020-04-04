#!/usr/bin/env ruby
# require 'pry'

class Solve
  attr_reader :activities

  def initialize(activities)
    @activities = activities.map.with_index do |activity, i|
      activity.split(' ').map(&:to_i) << i
    end
  end

  def result
    j_ends_at = 0
    c_ends_at = 0
    results = []

    # binding.pry
    activities.sort_by(&:first).each do |activity|
      if j_ends_at > activity.first
        return 'IMPOSSIBLE' if c_ends_at > activity.first

        c_ends_at = activity[1]
        results[activity.last] = 'C'
      else
        j_ends_at = activity[1]
        results[activity.last] = 'J'
      end
    end

    results.join('')
  end
end

T = gets.to_i
T.times do |t|
  n = gets.chomp.to_i
  activities = n.times.map { gets.chomp }
  solver = Solve.new(activities)
  puts "Case ##{t.succ}: #{solver.result}"
end
