require 'Date'
require 'Time'
require 'pry'
require './lib/dictionary'

class Enigma
  include Dictionary
  def random_key
    5.times.map { Random.rand(10) }
  end

  # any other way to do this while still passing an appropriate test

  def key_offset(key = random_key)
    key.map.with_index do |element, index|
      "#{element}#{key[index + 1]}".to_i
    end.shift(4)
  end

  def date_string
    Date.today.strftime("%m%d%y")
  end

  def date_offset
    date_squared = date_string.to_i ** 2
    date_squared = date_squared.to_s.split("")
    date_squared[-4..-1].map { |number| number.to_i }
  end

  def master_key(key = key_offset, date = date_offset)
    [key, date].transpose.map { |sub_arrays| sub_arrays.reduce(:+) }
  end

  def translate_chars(message)
    message = message.chars
    message.map do |char|
      CHARACTER_MAP[char]
    end.each_slice(4).to_a
  end

  def reduce_master_key(key = master_key)
    key.map do |offset|
      if offset > CHARACTER_MAP.length
        offset % CHARACTER_MAP.length
      end
    end
  end
end
