require 'spec_helper'

describe Speedflow::CommandLine do
  describe "#init" do
    it "should init a new project" do
      command = Speedflow::CommandLine.new("init", nil, nil, nil, nil)
      command.init.should == nil
    end
  end

  describe "#start" do
    it "should start a new item" do
      puts "ok"
      command = Speedflow::CommandLine.new("start", nil, nil, nil, nil)
      command.start.should == nil
    end
  end
end
