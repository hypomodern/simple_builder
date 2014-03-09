require 'spec_helper'

describe SimpleBuilder do
  let(:params) {
    { foo: 'bar' }
  }
  let(:test_builder) {
    Class.new(SimpleBuilder) do
      def new_instance; "HI THERE"; end
    end
  }

  context "initialization" do

    it "yields itself to a block if one is given" do
      SimpleBuilder.new(params) do |new_object|
        new_object.should be_an_instance_of(SimpleBuilder)
      end
    end

    context "without a given object" do
      it "sets self.object to the results of the #new_instance method" do
        builder = test_builder.new params
        builder.object.should == "HI THERE"
      end
    end

    context "with a given object" do
      it "sets self.object to the given object" do
        builder = test_builder.new params, "A Dummy Object"
        builder.object.should == "A Dummy Object"
      end
    end

  end

  describe "#build!" do
    let(:builder) { test_builder.new params }
    before do
      builder.object.stub(:save)
    end

    it "calls #set_attributes" do
      builder.should_receive(:set_attributes)
      builder.build!
    end

    it "attempts to save self.object" do
      builder.object.should_receive(:save)
      builder.build!
    end

    it "returns self.object" do
      builder.build!.should == builder.object
    end
  end

end