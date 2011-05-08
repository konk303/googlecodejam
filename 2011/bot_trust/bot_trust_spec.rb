require 'rubygems'
require 'rspec'

require "bot_trust"

describe BotTrust do
end

describe Bot do
  subject {
   Bot.new("orange")
  }

  it "should keep own color" do
    subject.instance_variable_get(:@color).should == "orange"
  end

end
