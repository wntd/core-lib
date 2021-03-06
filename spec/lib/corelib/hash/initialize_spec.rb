require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe "Hash#initialize", ->
  it "is private", ->
    hash_class.should have_private_instance_method("initialize")

  it "can be used to reset default_proc", ->
    h = new_hash("foo" => 1, "bar" => 2)
    h.default_proc.should == nil
    h.instance_eval { initialize { |h, k| k * 2 } }
    h.default_proc.should_not == nil
    h["a"].should == "aa"

  it "receives the arguments passed to Hash#new", ->
    HashSpecs::NewHash.new(:one, :two)[0].should == :one
    HashSpecs::NewHash.new(:one, :two)[1].should == :two

  it "returns self", ->
    h = hash_class.new
    h.send(:initialize).should equal(h)

  ruby_version_is ""..."1.9", ->
    it "raises a TypeError if called on a frozen instance", ->
      block = lambda { HashSpecs.frozen_hash.instance_eval { initialize() }}
      block.should raise_error(TypeError)

      block = lambda { HashSpecs.frozen_hash.instance_eval { initialize(nil) }  }
      block.should raise_error(TypeError)

      block = lambda { HashSpecs.frozen_hash.instance_eval { initialize(5) }    }
      block.should raise_error(TypeError)

      block = lambda { HashSpecs.frozen_hash.instance_eval { initialize { 5 } } }
      block.should raise_error(TypeError)

  ruby_version_is "1.9", ->
    it "raises a RuntimeError if called on a frozen instance", ->
      block = lambda { HashSpecs.frozen_hash.instance_eval { initialize() }}
      block.should raise_error(RuntimeError)

      block = lambda { HashSpecs.frozen_hash.instance_eval { initialize(nil) }  }
      block.should raise_error(RuntimeError)

      block = lambda { HashSpecs.frozen_hash.instance_eval { initialize(5) }    }
      block.should raise_error(RuntimeError)

      block = lambda { HashSpecs.frozen_hash.instance_eval { initialize { 5 } } }
      block.should raise_error(RuntimeError)
  end
