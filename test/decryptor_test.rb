require './test/helper_test'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/decryptor'

class DecryptorTest < Minitest::Test
  def test_it_can_find_current_map_values
    d = Decryptor.new
    expected = [[34, 31, 38, 38], [41, 63, 49, 41], [44, 38, 30]]
    message = "hello world"

    assert_equal expected, d.current_map_values(message)
  end

  def test_it_can_find_capital_letters
    d = Decryptor.new
    expected = [[1, 2, 3, 4], [5, 6]]
    message = "ABCDEF"

    assert_equal expected, d.current_map_values(message)
  end

  def test_it_can_find_numbers
    d = Decryptor.new
    expected = [[54, 55, 56, 57], [58]]
    message = "12345"

    assert_equal expected, d.current_map_values(message)
  end

  def test_it_can_find_symbols
    d = Decryptor.new
    expected = [[66, 67, 68, 69], [70, 85]]
    message = "@#$%^\\"

    assert_equal expected, d.current_map_values(message)
  end

  def test_it_adjusts_new_map_value
    d = Decryptor.new

    assert_equal 19, d.adjust_new_map_value(104)
    assert_equal 2, d.adjust_new_map_value(-83)
  end

  def test_it_can_find_decrypt_values
    d = Decryptor.new
    expected = [8, 85, 12, 12]
    actual = d.decrypt_values([14, 4, 27, 16], [6, 4, 15, 4])

    assert_equal expected, actual
  end

  def test_it_can_find_all_decrypt_values
    d = Decryptor.new
    expected = [34, 79, 38, 38, 41, 26, 12, 41, 44, 1, 30]
    actual = d.merge_new_decrypt_values("nd0pu9asxks", [6, 36, 15, 4])

    assert_equal expected, actual
  end

  def test_it_converts_decrypt_values_to_correct_keys
    d = Decryptor.new
    input = [34, 79, 38, 38, 41, 26, 12, 41, 44, 1, 85]
    expected = "h>lloZLorA\\"

    assert_equal expected, d.new_decrypt_chars(input)
  end
end
