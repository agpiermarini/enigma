require "pry"
require "./lib/enigma"

class Encrypt
  attr_accessor :input

  def initialize(input)
    @input = input
  end

  input    = ARGV[0]
  enigma   = Enigma.new
  date     = enigma.date_string
  key      = enigma.key_offset
  output   = ARGV[1]

  def read_file(file = input)
    File.read(file)
  end

  puts "Created '#{output_file}' with the key #{key} and date #{date}"

end
