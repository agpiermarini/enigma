require "pry"
require "./lib/enigma"

enigma  = Enigma.new
input   = ARGV[0]
key     = ARGV[1]
date    = ARGV[2]
output  = "encrypted.txt"


message = File.read(ARGV[0]).chomp
encrypted_text = enigma.encrypt(message)
File.open(output, 'w') { |file| file.write(encrypted_text)}

puts "Created '#{output}' with the key #{key} and date #{date}"
