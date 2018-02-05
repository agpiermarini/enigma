require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'Date'
require 'Time'
require './lib/encrypt.rb'

class EncryptTest < Minitest::Test

  def test_it_exists
    encrypt = Encrypt.new

    assert_instance_of Encrypt, encrypt
  end

  def test_it_takes_in_file
    encrypt = Encrypt.new
    
    assert_instance_of String, encrypt.read_file
  end
end
