#!/usr/bin/env ruby
class Universe

  def initialize(d, p)
    @d = d
    ps = p.split(//)
    @smallest = ps.select { |s| s == 'S' }.size
    @shoots = shoots(ps)
    @count = 0
  end

  def result
    if @d < @smallest
      'IMPOSSIBLE'
    else
      while @d < @shoots.reduce(:+).to_i
        move!
        @count += 1
      end
      @count
    end
  end

  private

  def shoots(ps)
    s = 1
    ps.map do |p|
      if p == 'C'
        s = s * 2
        nil
      else
        s
      end
    end.compact
  end

  def move!
    @shoots[-1] = @shoots.last / 2
    @shoots.sort!
  end
end

T = gets.to_i
T.times do |t|
  d, p = gets.split(/\s/)
  puts "Case ##{t.succ}: #{Universe.new(d.to_i, p).result}"
end
