require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'Date'
require 'Time'
require './lib/enigma.rb'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_it_can_create_random_key
    enigma = Enigma.new

    assert_equal 5, enigma.random_key.length
    refute_equal 9, enigma.random_key.length
  end

  def test_it_can_create_key_offset
    enigma = Enigma.new

    assert_equal [12, 23, 34, 45], enigma.key_offset([1, 2, 3, 4, 5])
    assert_equal [68, 89, 90, 1], enigma.key_offset([6, 8, 9, 0, 1])
  end

  def test_it_can_create_date_string
    enigma = Enigma.new

    assert_equal 6, enigma.date_string.length
  end

  def test_it_can_create_date_offset
    enigma = Enigma.new

    assert_equal 4, enigma.date_offset.length
  end

  def test_it_can_combine_arrays
    enigma = Enigma.new

    assert_equal [6, 8, 10, 12], enigma.total_rotation([4, 5, 6, 7], [2, 3, 4, 5])
  end

  def test_it_can_find_current_map_values
    enigma = Enigma.new
    expected = [[8, 5, 12, 12], [15, 37, 23, 15], [18, 12, 4]]
    message = "hello world"

    assert_equal expected, enigma.current_map_values(message)
  end

  def test_it_can_reduce_rotation_values
    enigma = Enigma.new

    assert_equal [5, 15, 32, 15], enigma.reduce_rotation([42, 89, 32, 15])
  end

  def test_it_converts_current_map_value_to_new_map_value
    enigma = Enigma.new
    expected = [14, 4, 27, 16, 21, 36, 1, 19, 24, 11, 19]
    actual = enigma.new_map_values("hello world", [6,36,15,4])

    assert_equal expected, actual
  end

  def test_it_converts_new_values
    enigma = Enigma.new
    expected = [14, 4, 27, 16, 21, 36, 1, 19, 24, 11, 19]

    assert_equal expected.length, enigma.new_chars(expected).length
    refute_equal expected, enigma.new_chars(expected)
  end

  def test_it_converts_new_values_to_correct_keys
    enigma = Enigma.new
    input = [14, 4, 27, 16, 21, 36, 1, 19, 24, 11, 19]
    expected = "nd0pu9asxks"

    assert_equal expected, enigma.new_chars(input)
  end

  def test_it_encrypts_message
    enigma = Enigma.new

    assert_instance_of String, enigma.encrypt("hello world")
    refute_equal "hello world", enigma.encrypt("hello world")
  end

  def test_it_encrypts_with_msg_key_and_date
    skip
    enigma = Enigma.new
    expected = "14kx8zv0aac"

    assert_equal expected, enigma.encrypt("hello world", 1234, "20518")
  end
end
