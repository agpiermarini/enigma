require './test/helper_test'
require 'minitest/autorun'
require 'minitest/pride'
require 'Date'
require 'Time'
require './lib/key_gen'

class KeyGenTest < Minitest::Test
  def test_it_can_create_key_offset
    k = KeyGen.new

    assert_equal [12, 23, 34, 45], k.key_offset([1, 2, 3, 4, 5])
    assert_equal [68, 89, 90, 1], k.key_offset([6, 8, 9, 0, 1])
  end

  def test_it_normalizes_key_passed_as_string
    k = KeyGen.new

    assert_instance_of Array, k.key_normalizer("12345")
    assert_equal [12, 23, 34, 45], k.key_normalizer("12345")
  end

  def test_it_can_create_date_string
    k = KeyGen.new

    assert_equal 6, k.date_string.length
  end

  def test_it_can_create_date_offset
    k = KeyGen.new

    assert_equal 4, k.date_offset.length
  end

  def test_it_can_combine_rotation_arrays
    k = KeyGen.new

    assert_equal [6, 8, 10, 12], k.total_rotation([4, 5, 6, 7], [2, 3, 4, 5])
  end

end
