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

    assert_equal 5, enigma.random_key(5, 10).length
    refute_equal 9, enigma.random_key(5, 10).length
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

    assert_equal [6, 8, 10, 12], enigma.master_key([4,5,6,7], [2,3,4,5])
  end
end
