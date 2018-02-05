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

  def test_it_can_translate_characters_to_correct_position
    enigma = Enigma.new
    expected = [[8, 5, 12, 12], [15, 37, 23, 15], [18, 12, 4]]
    message = "hello world"

    assert_equal expected, enigma.translate_chars(message)
  end

  def test_it_can_reduce_total_rotation
    enigma = Enigma.new

    assert_equal [5, 15, 32, 15], enigma.reduce_total_rotation([42, 89, 32, 15])
  end

  def test_it_converts_current_position_to_new_position
    enigma = Enigma.new
    expected = [14, 4, 27, 16, 21, 36, 1, 19, 24, 11, 19]
    actual = enigma.translate_to_new_position("hello world")

    assert_equal expected, actual
  end
end
