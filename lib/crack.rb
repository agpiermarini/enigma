require './lib/enigma'

enigma    = Enigma.new
input     = ARGV[0]
output    = ARGV[1]
date      = ARGV[2]

message = File.read(input).chomp
cracked_text = enigma.crack(message, date)
File.open(output, 'w') { |file| file.write(cracked_text) }

puts "Created '#{output}' with the cracked key #{enigma.cracked_key} and date #{date}"
