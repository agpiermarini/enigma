require 'pry'
require './lib/dictionary'
require './lib/keygen'

class Decryptor
  include Dictionary

  def initialize
    @keygen = KeyGen.new
  end

  def current_map_values(message)
    message.each_char.map do |char|
      CHAR_MAP[char]
    end.each_slice(4).to_a
  end

  def decrypt_values(letter_set, rotation = @keygen.total_rotation)
    letter_set.map.with_index do |position, rotation_index|
      new_map_position = position - rotation[rotation_index]
      if new_map_position > 0
        new_map_position % CHAR_MAP.length
      else
        new_map_position + CHAR_MAP.length
      end
    end
  end

  def merge_new_decrypt_values(message, rotation = total_rotation)
    current_positions = current_map_values(message)
    current_positions.map do |letter_set|
      decrypt_values(letter_set, rotation)
    end.flatten
  end

  def new_decrypt_chars(map_values = merge_new_decrypt_values)
    map_values.map do |value|
      CHAR_MAP.key(value)
    end.join
  end
end
