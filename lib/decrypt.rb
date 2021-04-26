require './lib/enigma'
enigma = Enigma.new
encrypted = File.open(ARGV[0], "r")

encrypted_text = encrypted.read

encrypted.close

decrypt_text = enigma.decrypt(encrypted_text, ARGV[2], ARGV[3])

decrypted = File.open(ARGV[1], "w")

decrypted.write(decrypt_text[:decryption])

decrypted.close

puts "Created #{ARGV[1]} with the key #{ARGV[2]} and date #{ARGV[3]}"