require 'rubygems'
require 'rspec'

require './rpi'

describe Rpi do
  subject {
  }

  describe "sizes_to_check" do
    before do
      @ary = [0,0,0]
    end
    subject {
      Rpi.new(@ary).send(:minimum_played_for_percent, @test)
    }

    it {
      @test = 20
      should == 5
    }
    it {
      @test = 80
      should == 5
    }
    it {
      @test = 25
      should == 4
    }
    it {
      @test = 30
      should == 10
    }
    it {
      @test = 40
      should == 5
    }
    it {
      @test = 33
      should == 100
    }
    it {
      @test = 0
      should == nil
    }
    it {
      @test = 100
      should == 1
    }
  end

end
