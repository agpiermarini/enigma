require 'Date'
require 'Time'
require 'pry'
require './lib/dictionary'

class Enigma
  include Dictionary
  attr_reader :random_key, :date_string

  def initialize
    @random_key  = 5.times.map { Random.rand(10) }
    @date_string = Date.today.strftime("%m%d%y")
  end

  def key_offset(key = random_key)
    key.map.with_index do |element, index|
      "#{element}#{key[index + 1]}".to_i
    end.shift(4)
  end

  def date_offset(date = date_string)
    date_squared = date.to_i ** 2
    date_squared = date_squared.to_s.split("")
    date_squared[-4..-1].map { |number| number.to_i }
  end

  def total_rotation(key = key_offset, date = date_offset)
    [key, date].transpose.map { |sub_arrays| sub_arrays.reduce(:+) }
  end

  def current_map_values(message)
    message.each_char.map do |char|
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

  def encrypt_values(letter_set, rotation = reduce_rotation)
    letter_set.map.with_index do |position, rotation_index|
      if position + rotation[rotation_index] < CHAR_MAP.length
        position + rotation[rotation_index]
      elsif position + rotation[rotation_index] > CHAR_MAP.length
        (position + rotation[rotation_index]) - CHAR_MAP.length
      else
        position
      end
    end
  end

  def merge_new_encrypt_values(message, rotation = reduce_rotation)
    current_positions = current_map_values(message)
    new_positions = []
    current_positions.map do |letter_set|
        new_positions << encrypt_values(letter_set, rotation)
    end
    new_positions.flatten
  end

  def new_chars(map_values = merge_new_encrypt_values)
    map_values.map do |value|
      CHAR_MAP.key(value)
    end.join
  end

  def key_normalizer(key)
      key = key.split("").map { |number| number.to_i }
      key_offset(key)
  end

  def encrypt(message, key = key_offset, date = date_offset)
    key = key_normalizer(key) if key.class == String
    date = date_offset(date) if date.class == String
    rotation = reduce_rotation(total_rotation(key, date))
    new_message = merge_new_encrypt_values(message, rotation)
    new_chars(new_message)
  end
end

# find_decrypted_positions
# find_encrypted_positions
