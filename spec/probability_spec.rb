require 'spec_helper'

module Probability
  extend Coal::Namespace
end

describe 'Probability' do
  before(:all) do
    Coal.namespace = Probability
    
    begin
      require 'c_files/probability'
    rescue Exception => @exception
    end
  end
  
  it "should not raise an exception when loading probability.c" do
    expect { raise @exception if @exception }.to_not raise_exception
  end
  
  it "should add the 'choose' method" do
    Probability.should respond_to :choose
  end
  
  describe ".choose(27)" do
    it { Probability.choose(10, 5).should == 252 }
  end
  
  after(:all) do
    Coal.namespace = Cl
  end
end

