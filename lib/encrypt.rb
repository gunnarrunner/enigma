require 'enigma'
enigma = Enigma.new
message = File.open(ARGV[0], "r")

message_text = message.read

message.close

encrypt_text = enigma.encrypt(message_text)

encrypted = File.open(ARGV[1], "w")

encrypted.write(encrypt_text)

writer.close