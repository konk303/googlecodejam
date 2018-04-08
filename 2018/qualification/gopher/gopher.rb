#!/usr/bin/env ruby
require 'logger'

STDOUT.sync = true

class Gopher
  def initialize(a)
    @logger = Logger.new('log.txt')
    @a = a
    sqrt = a ** (1 / 2.0)
    r = sqrt.to_i
    c = sqrt.to_i ** 2 < a ? sqrt.to_i : sqrt.to_i.succ
    @areas = (0..(r)).map { Array.new(c) }
    @digg_r = @areas.size - 2
    @digg_c = @areas[0].size - 2
  end

  def communicate_until_finish
    while true
      send!
      receive!
      @logger.debug @areas
      return if finished
      mark_digged
      decide_next_target
    end
  end

  private

  def decide_next_target
    needs_completed_rs = if @digg_r == (@areas.size - 2)
                           [@areas[@digg_r], @areas[@digg_r + 1]]
                         elsif @digg_r == 1
                           [@areas[@digg_r - 1], @areas[@digg_r]]
                         else
                           [@areas[@digg_r]]
                         end
    needs_completed_cs = needs_completed_rs.flat_map do |r|
      if @digg_c == (@areas[0].size - 2)
        [r[@digg_c], r[@digg_c + 1]]
      elsif @digg_c == 1
        [r[@digg_c - 1], r[@digg_c]]
      else
        [r[@digg_c]]
      end
    end
    return unless  needs_completed_cs.all?
    if @digg_c > 1
      @digg_c -= 1
    else
      @digg_r -= 1
      @digg_c = @areas[0].size - 2
    end
    decide_next_target
  end

  def mark_digged
    @areas[@digged_r - 1][@digged_c - 1] = true
  end

  def send!
    @logger.debug ['send', @digg_r + 1, @digg_c + 1]
    puts "#{@digg_r + 1} #{@digg_c + 1}"
  end

  def receive!
    @digged_r, @digged_c = gets.split(/\s/).map(&:to_i)
    @logger.debug ['receive', @digged_r, @digged_c]
  end

  def finished
    @digged_r <= 0 && @digged_c <= 0
  end
end

T = gets.to_i
T.times do |t|
  a = gets.to_i
  Gopher.new(a).communicate_until_finish
end
