require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'Date'
require 'Time'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_it_encrypts_message_using_default_key_and_date
    enigma = Enigma.new

    assert_instance_of String, enigma.encrypt("hello world")
    refute_equal "hello world", enigma.encrypt("hello world")
  end

  def test_it_encrypts_with_provided_key_and_date
    enigma = Enigma.new
    expected = "14)B8D\\E..@"

    assert_equal expected, enigma.encrypt("hello world", "12345", "20518")
  end

  def test_it_decrypts_message_using_default_key_and_date
    enigma = Enigma.new

    assert_instance_of String, enigma.decrypt("14kx8zv\\aac")
    refute_equal "14kx8z\\0aac", enigma.decrypt("14kx8z\\0aac")
  end

  def test_it_decrypts_with_provided_key_and_date
    enigma = Enigma.new
    expected = "heAAoZLDGA<"

    assert_equal expected, enigma.decrypt("14kx8zv0aac", "12345", "20518")
  end

  def test_it_can_find_key
    enigma = Enigma.new
    expected = 34591

    assert_equal expected, enigma.crack("(:Nv;bYy?CF)R:PnRc", "020718")
  end
end
