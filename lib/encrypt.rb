require './lib/enigma'

enigma  = Enigma.new
input   = ARGV[0]
output  = ARGV[1]

message = File.read(input).chomp
encrypted_text = enigma.encrypt(message)
File.open(output, 'w') { |file| file.write(encrypted_text)}

puts "Created '#{output}' with the key #{enigma.captured_key.join} and date #{enigma.captured_date}"
