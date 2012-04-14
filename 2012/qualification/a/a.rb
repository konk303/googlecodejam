#!/usr/bin/env ruby


class Googlerese
  def initialize(sample_in, sample_out)
    @from =  sample_in.gsub(/\s/, "").split("").uniq
    @to =  sample_out.gsub(/\s/, "").split("").uniq
    to_left_overs = []
    ("a".."z").to_a.each do |s|
      unless @to.index(s)
        to_left_overs << s
      end
    end
    ("a".."z").to_a.each do |s|
      unless @from.index(s)
        @from << s
        @to << to_left_overs.pop
      end
    end
    # p @from, @to
  end

  def translate(sentence)
    result = ""
    sentence.chars do |s|
      result << unless s.match(/\s/)
                  @to[@from.index(s)]
                else
                  s
                end
    end
    result
  end
end

sample_in = <<EOS
y qee
ejp mysljylc kd kxveddknmc re jsicpdrysi
rbcpc ypc rtcsra dkh wyfrepkym veddknkmkrkcd
de kr kd eoya kw aej tysr re ujdr lkgc jv
EOS
sample_out = <<EOS
a zoo
our language is impossible to understand
there are twenty six factorial possibilities
so it is okay if you want to just give up
EOS

googlerese = Googlerese.new(sample_in, sample_out)
T = ARGF.gets.to_i
T.times do |i|
  inputs = ARGF.gets.chomp
  puts "Case ##{i.succ}: #{googlerese.translate(inputs)}"
end
