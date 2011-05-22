#!/usr/bin/env ruby

class Rpi
  attr_reader :wp, :owp, :rpi, :results, :played, :won

  def initialize(results, schools)
    @results, @schools = results, schools
    @played = results.count {|i| ["0", "1"].include? i}
    @won = results.count("1")

  end

  def calc_wp
    @wp = @won / @played.to_f
  end

  def calc_owp
    a = []
    @results.each_with_index do |r, i|
      if (["0", "1"].include? r)
        other = @schools[i]
        other_played_without_me = other.played - 1
        other_won_without_me = (@results[i] == "0" ? other.won - 1 : other.won)
        other_wp_without_me = other_won_without_me / other_played_without_me.to_f
        a << other_wp_without_me
      end
    end
    @owp = a.inject(&:+) / a.size
  end

  def calc_oowp
    a = []
    @results.each_with_index do |r, i|
      a << ((["0", "1"].include? r) ? @schools[i].owp : nil)
    end
    a.compact!
   @oowp = a.inject(&:+) / a.size
  end

  def calc_rpi
    # p [@wp, @owp, @oowp]
    @rpi = 0.25 * @wp + 0.50 * @owp + 0.25 * @oowp
  end

  private

end

t = ARGF.gets.to_i
t.times do |i|
  n = ARGF.gets.to_i
  schools = []
  n.times do |j|
    params = ARGF.gets.chomp.split(//)
    schools << Rpi.new(params, schools)
  end
  schools.each(&:calc_wp)
  schools.each(&:calc_owp)
  schools.each(&:calc_oowp)
  schools.each(&:calc_rpi)
  puts "Case ##{i.succ}:"
  schools.each do |s|
    puts s.rpi
  end
end
