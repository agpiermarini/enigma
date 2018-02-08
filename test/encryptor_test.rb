require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'Date'
require 'Time'
require './lib/encryptor'

class EncryptorTest < Minitest::Test
  
  def test_it_can_find_encrypt_values
    enigma = Enigma.new
    expected = [14, 41, 27, 16]
    actual = enigma.encrypt_values([8,5,12,12], [6,36,15,4])

    assert_equal expected, actual
  end

  def test_it_can_find_number_and_symbol_encrypt_values
    enigma = Enigma.new
    expected = [6, 21, 74, 60]
    actual = enigma.encrypt_values([85,70,59,56], [6,36,15,4])

    assert_equal expected, actual
  end

  def test_it_can_find_all_encrypt_values
    enigma = Enigma.new
    expected = [40, 67, 53, 42, 47, 14, 64, 45, 50, 74, 45]
    actual = enigma.merge_new_encrypt_values("hello world", [6,36,15,4])

    assert_equal expected, actual
  end

  def test_it_can_find_all_encrypt_values
    enigma = Enigma.new
    expected = [40, 7, 53, 4, 59, 14, 64, 57, 50, 36, 8, 3, 69, 85]
    actual = enigma.merge_new_encrypt_values("h3l\\0 w0r\\<| w", [6,36,15,4])

    assert_equal expected, actual
  end

  def test_it_converts_encrypt_values
    enigma = Enigma.new
    expected = [14, 4, 27, 16, 21, 36, 1, 19, 24, 11, 19]

    assert_equal expected.length, enigma.new_encrypt_chars(expected).length
    refute_equal expected, enigma.new_encrypt_chars(expected)
  end

  def test_it_converts_encrypt_values_to_correct_keys
    enigma = Enigma.new
    expected = "NDaPUjASXKS"
    input = [14, 4, 27, 16, 21, 36, 1, 19, 24, 11, 19]

    assert_equal expected, enigma.new_encrypt_chars(input)
  end

  def test_it_converts_encrypt_symbol_values_to_correct_keys
    enigma = Enigma.new
    expected = "h3l\\0 .4xjHC%\\"
    input = [34, 56, 38, 85, 53, 63, 64, 57, 50, 36, 8, 3, 69, 85]

    assert_equal expected, enigma.new_encrypt_chars(input)
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
end
