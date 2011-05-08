#!/usr/bin/env ruby


class BotTrust
  attr_reader :steps

  def initialize(orders)
    @orders = orders
    @steps = 0
    @finished = false
    @orange= Bot.new(:O)
    @blue= Bot.new(:B)
  end

  def solve
    set_orders
    until @finished do
#       puts "step:#{@steps.succ}"
      [@blue, @orange].each do |bot|
        bot.move
      end
      if @blue.pushed or @orange.pushed
        set_orders
      end
      @steps += 1
    end
  end

  private

  def set_orders
    return @finished = true unless @orders.any?
    next_order = @orders.shift
    target = next_order[0] == @blue.color ? @blue : @orange
    target.order = next_order[1]
    target.can_push = true
    oposite = target == @blue ? @orange : @blue
    oposite.order = (oposite_order = @orders.find{|o| o[0] == oposite.color}) ?
    oposite_order[1] : 0
    oposite.can_push = false
  end

end

class Bot
  attr_accessor :can_push, :order
  attr_reader :color, :pushed

  def initialize(color)
    @color = color
    @position = 1
  end

  def move
    @pushed = false
    if @position == @order
      if @can_push
        @pushed = true
#         puts "push #{@color}"
      end
    else
      @position += (@position > @order ? -1 : 1)
    end
#     puts "#{@color}:#{@position}"
  end
end

T = ARGF.gets.to_i
T.times do |i|
  inputs = ARGF.gets.split(/\s/)
  n = inputs.shift.to_i
  orders = []
  n.times do
    orders << inputs.shift(2)
  end
  bt = BotTrust.new(orders.map{|c| [c[0].to_sym, c[1].to_i]})
  bt.solve
  puts "Case ##{i.succ}: #{bt.steps}"
end
