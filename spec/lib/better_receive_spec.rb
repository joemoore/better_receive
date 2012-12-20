require 'spec_helper'

describe BetterReceive do
  class Foo
    def bar(baz = nil)
    end
  end

  describe "#better_receive" do
    let(:foo) { Foo.new }

    it "determines whether an object responds to a method" do
      foo.should_receive(:respond_to?).with(:bar).and_call_original

      foo.better_receive(:bar)

      foo.bar
    end

    it "raises an error if it the method is not defined" do
      foo.should_receive(:respond_to?).with(:baz).and_call_original
      expect {
        foo.better_receive(:baz)
      }.to raise_error RSpec::Expectations::ExpectationNotMetError
    end

    it "checks that the object receives the specified method" do
      foo.should_receive(:should_receive).and_call_original

      foo.better_receive(:bar)

      foo.bar
    end

    it "returns an rspec mock object(responds to additional matchers ('with', 'once'...))" do
      foo.better_receive(:bar) === RSpec::Mocks::MessageExpectation

      foo.bar

      foo.better_receive(:bar).with('wibble')

      foo.bar('wibble')
    end
  end
end
