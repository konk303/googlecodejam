require 'rubygems'
require 'rspec'

require 'scalar'

describe Scalar do
  subject {
    Scalar.new(@v1, @v2)
  }

  describe "total" do
    subject {
      Scalar.new(@v1, @v2s).send(:total, @test1, @test2)
    }
    it {
      @test1 = [1,2]
      @test2 = [3,4]
      should == 11
    }
    it {
      @test1 = [1,2,3]
      @test2 = [3,4,5]
      should == 26
    }
  end
end
