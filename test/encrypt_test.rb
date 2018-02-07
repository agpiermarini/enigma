require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'Date'
require 'Time'
require './lib/encrypt.rb'

class EncryptTest < Minitest::Test

  # def test_it_exists
  #   encrypt = Encrypt.new
  #
  #   assert_instance_of Encrypt, encrypt
  # end

  def test_it_takes_in_file
    encrypt = Encrypt.new

    assert_instance_of String, encrypt.read_file("./lib/message.txt")
  end

  def test_it_reads_txt_file
    encrypt = Encrypt.new

    assert_equal "hello world", encrypt.read_file("./lib/message.txt")
  end

  def test_it_encrypts
    encrypt = Encrypt.new
    expected = "14kx8zv0aac"

    assert_equal expected, encrypt.encrypt("hello world", "12345", "020518")
  end
  # def test_it_writes_to_file
  #   encrypt = Encrypt.new
  #
  #
  # end
end
