#!/usr/bin/env ruby


class Magicka
  def initialize(*param)
    @combines, @opposes, @elements = param
    @combiners = @combines.map {|c| Combiner.new(c)}
    @opposers = @opposes.map {|o| Opposer.new(o)}
    @list = []
  end


  def invoke_all
    @elements.each do |e|
      invoke(e)
    end
  end

  def result_string
    "[#{@list.join(", ")}]"
  end

  private

  def invoke(element)
    @list << element
    @combiners.each {|c| c.apply(@list)}
    @opposers.each {|o| o.apply(@list)}
  end
end

class Combiner
  def initialize(rule)
    base_1, base_2, @replace = rule.split("")
    @base = [base_1, base_2].sort
  end

  def apply(list)
    return false if list.size < 2
    last = list[-2, 2].sort
    if last == @base
      list.pop(2)
      list << @replace
    end
  end
end

class Opposer
  def initialize(rule)
    @base_1, @base_2 = rule.split("")
  end

  def apply(list)
    if list.include? @base_1 and list.include? @base_2
      list.clear
    end
  end
end

T = ARGF.gets.to_i
T.times do |i|
  inputs = ARGF.gets.split(/\s/)

  combines = []
  c = inputs.shift.to_i
  c.times do
    combines << inputs.shift
  end
  opposes = []
  d = inputs.shift.to_i
  d.times do
    opposes << inputs.shift
  end
  elements = []
  n = inputs.shift.to_i
  s = inputs.shift
  n.times do |t|
    elements << s[t].chr
  end

  magicka = Magicka.new(combines, opposes, elements)
  magicka.invoke_all
  puts "Case ##{i.succ}: #{magicka.result_string}"
end
