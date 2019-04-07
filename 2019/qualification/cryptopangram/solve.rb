#!/usr/bin/env ruby
# require 'logger'
# require 'pry'

class Solve
  attr_reader :n, :size, :ciphertext, :encrypted, :dictionary
  def initialize(n_length, ciphertext)
    # @n, @size = n_length.split(' ').map(&:to_i)
    @ciphertext = ciphertext.scan(/\d+/).map(&:to_i)
    @encrypted = Array.new
  end

  def message
    decrypt!
    create_dictionary!
    # p ciphertext, encrypted, dictionary
    encrypted.map { |code| dictionary[code] }.join('')
  end

  private

  def decrypt!
    ciphertext.each_cons(2).with_index do |(first, second), i|
      next if first == second
      encrypted[i.succ] = first.gcd(second)
    end
    encrypted.size.pred.downto(0) do |i|
      encrypted[i.pred] = ciphertext[i.pred] / encrypted[i]
    end
    1.upto(ciphertext.size.pred) do |i|
      encrypted[i.succ] = ciphertext[i] / encrypted[i]
    end
  end

  def create_dictionary!
    @dictionary = encrypted.uniq.sort.zip('A'..'Z').to_h
  end
end

T = gets.to_i
T.times do |t|
  n_length = gets.chomp
  ciphertext = gets.chomp
  puts "Case ##{t.succ}: #{Solve.new(n_length, ciphertext).message}"
end
