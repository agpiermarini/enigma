require "minitest/autorun"
require "minitest/pride"
require "pry"
require "Date"
require "Time"
require "./lib/encrypt.rb"

class EncryptTest < Minitest::Test

  def test_it_exists
    encrypt = Encrypt.new

    assert_instance_of Encrypt, encrypt
  end

  def test_it_can_create_random_key
    encrypt = Encrypt.new

    assert_equal 5, encrypt.random_key(5,10).length
    refute_equal 9, encrypt.random_key(5,10).length
  end

  def test_it_can_create_key_offset
    encrypt = Encrypt.new

    assert_equal [12, 23, 34, 45], encrypt.key_offset([1,2,3,4,5])
    assert_equal [68,89,90,1], encrypt.key_offset([6,8,9,0,1])
  end

  # def test_that_it_can_create_date
  #   encrypt = Encrypt.new
  #
  #   assert_equal Date.today, encrypt.create_date
  # end

  def test_it_can_create_date_string
    encrypt = Encrypt.new

    assert_equal 8, encrypt.date_offset.length
  end

  def test_it_can_create_date_offset
    encrypt = Encrypt.new

    assert_equal 4, encrypt.date_offset
  end

end
