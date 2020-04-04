#!/usr/bin/env ruby
require 'pry'

class Solve
  attr_reader :n, :matrix

  def initialize(n, rows)
    @n = n
    @matrix = rows.map { |row| row.split(' ').map(&:to_i) }
  end

  def trace
    matrix.map.with_index { |row, i| row[i] }.inject(:+)
  end

  def repeated_rows_count
    matrix.count { |row| row.uniq.size < n }
  end

  def repeated_cols_count
    (0..n.pred).to_a.count { |i| matrix.map { |row| row[i] }.uniq.size < n }
  end
end

T = gets.to_i
T.times do |t|
  n = gets.chomp.to_i
  rows = n.times.map { gets.chomp }
  result = Solve.new(n, rows)
  puts "Case ##{t.succ}: #{result.trace} #{result.repeated_rows_count} #{result.repeated_cols_count}"
end
