require './test/helper_test'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
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

  def test_it_encrypts_message_using_default_key_and_date
    enigma = Enigma.new

    assert_instance_of String, enigma.encrypt("hello world")
    refute_equal "hello world", enigma.encrypt("hello world")
  end

  def test_it_encrypts_with_provided_key_and_date
    enigma = Enigma.new
    expected = "14)B8D\\E..@"
    actual = enigma.encrypt("hello world", [12, 23, 34, 45], [8, 3, 2, 4])

    assert_equal expected, actual
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
    enigma.crack("(:Nv;bYy?CF)R:PnRc", "020718")

    assert_equal "34591", enigma.cracked_key
  end
end
