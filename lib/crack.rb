require "pry"
require './lib/enigma'
require './lib/key_gen'

enigma    = Enigma.new
keygen    = KeyGen.new
input     = ARGV[0]
output    = ARGV[1]
date      = ARGV[2]

message = File.read(input).chomp
cracked_key = enigma.crack(message, date)
cracked_text = enigma.decrypt(message, keygen.key_normalizer(cracked_key.to_s), date)
File.open(output, 'w') { |file| file.write(cracked_text)}

puts "Created '#{output}' with the cracked key #{cracked_key} and date #{date}"
