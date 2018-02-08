require 'pry'
require './lib/key_gen'

class Encryptor
  include Dictionary

  def initialize
    @keygen = KeyGen.new
  end

  def current_map_values(message)
    message.each_char.map do |char|
      CHAR_MAP[char]
    end.each_slice(4).to_a
  end

  def encrypt_values(letter_set, rotation = @keygen.total_rotation)
    letter_set.map.with_index do |position, rotation_index|
      new_map_position = position + rotation[rotation_index]
      if new_map_position > CHAR_MAP.length
        new_map_position % CHAR_MAP.length
      else
        new_map_position
      end
    end
  end

  def merge_new_encrypt_values(message, rotation = total_rotation)
    current_positions = current_map_values(message)
    current_positions.map do |letter_set|
      encrypt_values(letter_set, rotation)
    end.flatten
  end

  def new_encrypt_chars(map_values = merge_new_encrypt_values)
    map_values.map do |value|
      CHAR_MAP.key(value)
    end.join
  end
end
