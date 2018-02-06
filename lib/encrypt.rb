require "pry"
require "./lib/enigma"

input   = ARGV[0]
key     = ARGV[1]
date    = ARGV[2]
enigma  = Enigma.new
output  = "encrypted.txt"



message = File.read(ARGV[0]).chomp
encrypted_text = enigma.encrypt(message)
File.open(output, 'w') { |file| file.write(encrypted_text)}

puts "Created '#{output}' with the key #{enigma.random_key.join} and date #{enigma.date_string}"
