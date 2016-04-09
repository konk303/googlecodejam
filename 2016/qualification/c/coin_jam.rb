#!/usr/bin/env ruby

require 'prime'
require 'active_support'
require 'active_support/core_ext'
require 'pry'

class CoinJams
  attr_reader :results

  def initialize(length, required_size)
    @results = []
    last_result = nil
    required_size.times do
      result = CoinJam.new(length, last_result)
      @results << result
      last_result = result.jam_coin
    end
  end

  class  CoinJam
    attr_reader :jam_coin, :length

    def initialize(length, from)
      @length = length
      find_jam_coin!(from)
    end

    def to_s
      ([jam_coin].concat divisors).join(' ')
    end

    private

    def find_jam_coin!(from)
      test = from.present? ? (from.to_i(2) + 2) : "1#{"0" * (length - 2)}1".to_i(2)
      until valid?(test)
        test = test + 2
      end
      @jam_coin = test.to_s(2)
    end

    def valid?(i)
      2.upto(10).none? do |base|
        i.to_s(2).to_i(base).prime?
      end
    end

    def divisors
      2.upto(10).map do |base|
        jam_coin.to_i(base).prime_division.first.first
      end
    end
  end
end

T = ARGF.gets.to_i
T.times do |t|
  n, j = ARGF.gets.split(/\s/).map(&:to_i)
  puts "Case ##{t.succ}:"
  puts CoinJams.new(n, j).results
end
