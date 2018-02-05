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

  def total_rotation(key = key_offset, date = date_offset)
    [key, date].transpose.map { |sub_arrays| sub_arrays.reduce(:+) }
  end

  def translate_chars(message)
    message = message.chars
    message.map do |char|
      CHARACTER_MAP[char]
    end.each_slice(4).to_a
  end

  def reduce_total_rotation(rotation_values = total_rotation)
    rotation_values.map do |rotation_value|
      if rotation_value > CHARACTER_MAP.length
        rotation_value % CHARACTER_MAP.length
      else
        rotation_value
      end
    end
  end

  def translate_to_new_position(message)
    current_positions = translate_chars(message)
    rotation = [6,36,15,4]
    new_positions = Array.new
    index_counter = 0
    current_positions.length.times do
      #index_counter = 0
      current_positions[index_counter].map.with_index do |position, rotation_index|
        if position + rotation[rotation_index] < CHARACTER_MAP.length
          new_positions << position + rotation[rotation_index]
        elsif position + rotation[rotation_index] > CHARACTER_MAP.length
          new_positions << (position + rotation[rotation_index]) - CHARACTER_MAP.length
        else
          new_positions << position
        end
      end
      index_counter += 1
    end
    new_positions
  end
end
