require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "Time#to_a", ->
  it "returns a 10 element array representing the deconstructed time", ->
    # Testing with America/Regina here because it doesn't have DST.
    with_timezone("America/Regina") do
      R.Time.at(0).to_a.should == [0, 0, 18, 31, 12, 1969, 3, 365, false, "CST"]
