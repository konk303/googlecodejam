#!/usr/bin/env ruby

def valid_cases(smallest, largest)
  result = 0
  (smallest..largest).each do |i|
    results = []
    next if i < 12
    strings = i.to_s.split("")
    strings.length.pred.times do |s|
      test_s = strings.clone
      s.succ.times do
        test_s.unshift(test_s.pop)
      end
       # p i, s, test_s, "-"
      next if test_s[0] == "0"
      next if strings[0].to_i > test_s[0].to_i
      test_n = test_s.join.to_i
      if i < test_n && test_n <= largest
        # p i, test_n, largest, "-"
        results << test_n
      end
    end
    result += results.uniq.length
  end
  result
end

T = ARGF.gets.to_i
T.times do |i|
  n, m = ARGF.gets.split(/\s/).map(&:to_i)
  puts "Case ##{i.succ}: #{valid_cases(n, m)}"
end
