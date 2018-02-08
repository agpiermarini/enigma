require 'Date'
require 'Time'
require 'pry'

class KeyGen
  attr_reader   :random_key,
                :date_string

  def initialize
    @random_key  = 5.times.map { Random.rand(10) }
    @date_string = Date.today.strftime("%d%m%y")
  end

  def key_offset(key = random_key)
    key.map.with_index do |element, index|
      "#{element}#{key[index + 1]}".to_i
    end.shift(4)
  end

  def key_normalizer(key)
    key = key.split("").map { |number| number.to_i }
    key_offset(key)
  end

  def date_offset(date = date_string)
    date_squared = date.to_i ** 2
    date_squared = date_squared.to_s.split("")
    date_squared[-4..-1].map { |number| number.to_i }
  end

  def total_rotation(key = key_offset, date = date_offset)
    [key, date].transpose.map { |sub_arrays| sub_arrays.sum }
  end
end
