require 'rubygems'
require 'rspec'

$:.unshift File.dirname(__FILE__)
require "1a"

describe TypePassword do
  subject {
    TypePassword.new(1, 2, [0.1,0.2])
  }

  describe "inputs" do
    it "should keep typed" do
      subject.instance_variable_get(:@typed).should == 1
    end
    it "should keep length" do
      subject.instance_variable_get(:@length).should == 2
    end
    it "should keep probabilities" do
      subject.instance_variable_get(:@probabilities).should == [0.1, 0.2]
    end
  end

  describe "giving up" do
    it "length when giving up" do
      subject.giving_up.should == 4
    end
  end
  describe "smallest_expected" do
    it {subject.smallest_expected.should == 3}
  end

end

describe "calc" do
  correct = 0.6
  wrong = 0.4
  it "should add expected strokes" do
    ((correct * correct * 4 + correct * wrong * 10 + wrong * correct * 10 + wrong * wrong * 10)*100).to_i.should == 784
  end
end



  # describe Scores do
# end

# describe Scores do
#   subject {
#    Scores.new("orange", 2, 3, 4)
#   }

#   it "should keep own color" do
#     subject.instance_variable_get(:@dancers).should == "orange"
#   end

# end
