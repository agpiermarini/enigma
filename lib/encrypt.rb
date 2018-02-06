require "pry"
require "./lib/enigma"

enigma  = Enigma.new
input   = ARGV[0]
output  = ARGV[1]
key     = enigma.random_key.join
date    = enigma.date_string

message = File.read(input).chomp
encrypted_text = enigma.encrypt(message)
File.open(output, 'w') { |file| file.write(encrypted_text)}

puts "Created '#{output}' with the key #{key} and date #{date}"
