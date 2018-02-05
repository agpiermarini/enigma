require 'Date'
require 'Time'
require 'pry'
require './lib/dictionary'

class Enigma
  include Dictionary
  def random_key
    5.times.map { Random.rand(10) }
  end

  def key_offset(key = random_key)
    key.map.with_index do |element, index|
      "#{element}#{key[index + 1]}".to_i
    end.shift(4)
  end

  def date_string
    Date.today.strftime("%m%d%y")
  end

  def date_offset(date = date_string)
    date_squared = date.to_i ** 2
    date_squared = date_squared.to_s.split("")
    date_squared[-4..-1].map { |number| number.to_i }
  end

  # may need to consider setting this method to call date_offset and key_offset methods,
  # with arguments of (random_key and date_string) to meet the key & date are optional spec
  def total_rotation(key = key_offset, date = date_offset)
    [key, date].transpose.map { |sub_arrays| sub_arrays.reduce(:+) }
  end

  def current_map_values(message)
    message.chars.map do |char|
      CHAR_MAP[char]
    end.each_slice(4).to_a
  end

  def reduce_rotation(rotation_values = total_rotation)
    rotation_values.map do |rotation|
      if rotation > CHAR_MAP.length
        rotation % CHAR_MAP.length
      else
        rotation
      end
    end
  end

  def new_map_values(message, rotation = reduced_rotation)
    current_positions = current_map_values(message)
    new_positions = []
    current_positions.each do |letter_set|
      # break this map branch into new method
      letter_set.map.with_index do |position, rotation_index|
        if position + rotation[rotation_index] < CHAR_MAP.length
          new_positions << position + rotation[rotation_index]
        elsif position + rotation[rotation_index] > CHAR_MAP.length
          new_positions << (position + rotation[rotation_index]) - CHAR_MAP.length
        else
          new_positions << position
        end
      end
    end
    new_positions
  end

  def new_chars(map_values = new_map_values)
    map_values.map do |value|
      CHAR_MAP.key(value)
    end.join
  end
end

# find_decrypted_positions
# find_encrypted_positions
