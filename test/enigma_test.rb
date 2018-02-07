require_relative 'helper_test'
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

  def test_it_normalizes_key_passed_as_string
    enigma = Enigma.new

    assert_instance_of Array, enigma.key_normalizer("12345")
    assert_equal [12, 23, 34, 45], enigma.key_normalizer("12345")
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
    expected = [[34, 31, 38, 38], [41, 63, 49, 41], [44, 38, 30]]
    message = "hello world"

    assert_equal expected, enigma.current_map_values(message)
  end

  def test_it_can_find_capital_letters
    enigma = Enigma.new
    expected = [[1, 2, 3, 4], [5, 6]]
    message = "ABCDEF"

    assert_equal expected, enigma.current_map_values(message)
  end

  def test_it_can_find_numbers
    enigma = Enigma.new
    expected = [[54, 55, 56, 57], [58]]
    message = "12345"

    assert_equal expected, enigma.current_map_values(message)
  end

  def test_it_can_find_symbols
    enigma = Enigma.new
    expected = [[66, 67, 68, 69], [70, 85]]
    message = '@#$%^\\'

    assert_equal expected, enigma.current_map_values(message)
  end


  def test_it_can_reduce_rotation_values
    skip
    enigma = Enigma.new

    assert_equal [42, 4, 32, 15], enigma.reduce_rotation([42, 89, 32, 15])
  end

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

  def test_it_can_find_decrypt_values
    enigma = Enigma.new
    expected = [8, 85, 12, 12]
    actual = enigma.decrypt_values([14, 4, 27, 16], [6,4,15,4])

    assert_equal expected, actual
  end

  def test_it_can_find_all_decrypt_values
    enigma = Enigma.new
    expected = [34, 79, 38, 38, 41, 26, 12, 41, 44, 1, 30]
    actual = enigma.merge_new_decrypt_values("nd0pu9asxks", [6,36,15,4])

    assert_equal expected, actual
  end

  def test_it_converts_decrypt_values_to_correct_keys
    enigma = Enigma.new
    input = [34, 79, 38, 38, 41, 26, 12, 41, 44, 1, 85]
    expected = "h>lloZLorA\\"

    assert_equal expected, enigma.new_decrypt_chars(input)
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
