require './lib/enigma'

enigma  = Enigma.new
input   = ARGV[0]
output  = ARGV[1]
key     = ARGV[2]
date    = ARGV[3]

message = File.read(input).chomp
decrypted_text = enigma.decrypt(message, key, date)
File.open(output, 'w') { |file| file.write(decrypted_text)}

puts "Created '#{output}' with the key #{key} and date #{date}"
