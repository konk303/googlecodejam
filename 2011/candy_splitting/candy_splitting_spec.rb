require 'rubygems'
require 'rspec'

require 'candy_splitting'

describe CandySplitting do
  subject {
    CandySplitting.new(@ary)
  }

  describe "sizes_to_check" do
    subject {
      CandySplitting.new(@ary).send(:sizes_to_check)
    }
    it {
      @ary = [1,2,3]
      should == [1]
    }
    it {
      @ary = [1,2,3,4]
      should == [1,2]
    }
    it {
      @ary = [1,2,3,4,5]
      should == [1,2]
    }
    it {
      @ary = [1,2,3,4,5,6]
      should == [1,2,3]
    }
  end

  describe "possibilities" do
    subject {
      CandySplitting.new(@ary).send(:possibilities)
    }
    it {
      @ary = [1,2,3]
      should == [[1], [2], [3]]
    }
    it {
      @ary = [1,2,3,4]
      should == [[1], [2], [3], [4], [1,2], [1,3], [1,4], [2,3], [2,4], [3,4]]
    }
    it {
      @ary = [5,5]
      should == [[5], [5]]
    }
  end

  describe "others" do
    it {
      @ary = [1,2,3]
      subject.send(:others, [1]).should == [2,3]
    }
    it {
      @ary = [1,2,3]
      subject.send(:others, [1,3]).should == [2]
    }
    it {
      @ary = [5,5]
      subject.send(:others, [5]).should == [5]
    }
  end

  describe "patrics_sum" do
    it {
      subject.send(:patrics_sum, [12, 5]).should == 9
    }
    it {
      subject.send(:patrics_sum, [5, 4]).should == 1
    }
    it {
      subject.send(:patrics_sum, [7, 9]).should == 14
    }
    it {
      subject.send(:patrics_sum, [50, 10]).should == 56
    }
  end
end
