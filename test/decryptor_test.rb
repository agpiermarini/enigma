require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'Date'
require 'Time'
require './lib/decryptor'

class DecryptorTest < Minitest::Test

  def test_it_can_find_decrypt_values
    enigma = Enigma.new
    expected = [8, 85, 12, 12]
    actual = enigma.decrypt_values([14, 4, 27, 16], [6, 4, 15, 4])

    assert_equal expected, actual
  end

  def test_it_can_find_all_decrypt_values
    enigma = Enigma.new
    expected = [34, 79, 38, 38, 41, 26, 12, 41, 44, 1, 30]
    actual = enigma.merge_new_decrypt_values("nd0pu9asxks", [6, 36, 15, 4])

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
end