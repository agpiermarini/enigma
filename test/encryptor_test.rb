require './test/helper_test'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/encryptor'

class EncryptorTest < Minitest::Test
  def test_it_can_find_current_map_values
    e = Encryptor.new
    expected = [[34, 31, 38, 38], [41, 63, 49, 41], [44, 38, 30]]
    message = "hello world"

    assert_equal expected, e.current_map_values(message)
  end

  def test_it_can_find_capital_letters
    e = Encryptor.new
    expected = [[1, 2, 3, 4], [5, 6]]
    message = "ABCDEF"

    assert_equal expected, e.current_map_values(message)
  end

  def test_it_can_find_numbers
    e = Encryptor.new
    expected = [[54, 55, 56, 57], [58]]
    message = "12345"

    assert_equal expected, e.current_map_values(message)
  end

  def test_it_can_find_symbols
    e = Encryptor.new
    expected = [[66, 67, 68, 69], [70, 85]]
    message = '@#$%^\\'

    assert_equal expected, e.current_map_values(message)
  end

  def test_it_can_find_encrypt_values
    e = Encryptor.new
    expected = [14, 41, 27, 16]
    actual = e.encrypt_values([8, 5, 12, 12], [6, 36, 15, 4])

    assert_equal expected, actual
  end

  def test_it_can_find_number_and_symbol_encrypt_values
    e = Encryptor.new
    expected = [6, 21, 74, 60]
    actual = e.encrypt_values([85, 70, 59, 56], [6, 36, 15, 4])

    assert_equal expected, actual
  end

  def test_it_adjusts_new_map_value
    e = Encryptor.new

    assert_equal 19, e.adjust_new_map_value(104)
    assert_equal 54, e.adjust_new_map_value(54)
  end

  def test_it_can_find_all_encrypt_values
    e = Encryptor.new
    expected = [40, 67, 53, 42, 47, 14, 64, 45, 50, 74, 45]
    actual = e.merge_new_encrypt_values("hello world", [6, 36, 15, 4])

    assert_equal expected, actual
  end

  def test_it_converts_encrypt_values
    e = Encryptor.new
    expected = [14, 4, 27, 16, 21, 36, 1, 19, 24, 11, 19]

    assert_equal expected.length, e.new_encrypt_chars(expected).length
    refute_equal expected, e.new_encrypt_chars(expected)
  end

  def test_it_converts_encrypt_values_to_correct_keys
    e = Encryptor.new
    expected = "NDaPUjASXKS"
    input = [14, 4, 27, 16, 21, 36, 1, 19, 24, 11, 19]

    assert_equal expected, e.new_encrypt_chars(input)
  end

  def test_it_converts_encrypt_symbol_values_to_correct_keys
    e = Encryptor.new
    expected = "h3l\\0 .4xjHC%\\"
    input = [34, 56, 38, 85, 53, 63, 64, 57, 50, 36, 8, 3, 69, 85]

    assert_equal expected, e.new_encrypt_chars(input)
  end

  def test_it_can_find_all_encrypt_values_with_symbols
    e = Encryptor.new
    expected = [40, 7, 53, 4, 59, 14, 64, 57, 50, 36, 8, 3, 69, 85]
    actual = e.merge_new_encrypt_values("h3l\\0 w0r\\<| w", [6, 36, 15, 4])

    assert_equal expected, actual
  end
end
