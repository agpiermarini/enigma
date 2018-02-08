require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'Date'
require 'Time'
require './lib/crack'

class CrackerTest < Minitest::Test

  def test_it_can_find_key
    c = Cracker.new
    expected = 34591

    assert_equal expected, c.crack("(:Nv;bYy?CF)R:PnRc", "020718")
  end

end
