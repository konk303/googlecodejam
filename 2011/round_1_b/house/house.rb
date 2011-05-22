#!/usr/bin/env ruby

class House
  attr_reader :result

  def initialize(v, walls)
    @v = Array.new(v)
    @walls = walls
    get_rooms
    p @v, @walls, @rooms
  end

  def simulate
  end

  private

  def get_rooms
    @rooms = [].tap do |rooms|
      @walls.each do |wall|
        
      end
    end
  end
end

t = ARGF.gets.to_i
t.times do |i|
  n, m = ARGF.gets.chomp.split(" ").map(&:to_i)
  starts = ARGF.gets.chomp.split(" ").map(&:to_i)
  ends = ARGF.gets.chomp.split(" ").map(&:to_i)
  walls = [].tap do |walls|
    m.times do |j|
      walls << [starts[j], ends[j]]
    end
  end
  house = House.new(n, walls)
  house.simulate
  puts "Case ##{i.succ}: #{house.result}"
end
