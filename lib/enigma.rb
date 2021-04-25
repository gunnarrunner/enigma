class Enigma
ALPHABET = ("a".."z").to_a << " "

  attr_reader :key_encrypt_arrays,
              :key_decrypt_arrays
  def initialize
      @key_encrypt_arrays = []
      @key_decrypt_arrays = []
  end

  def encrypt(message, key, date)
    last_4_of_date(date)
    key_encrypt_values(key)
    combined_shift = last_4_of_date(date).zip(@key_encrypt_arrays)
    shift = combined_shift.map do |shift|
      shift.sum
    end
    x = message.chars.map {|c| ALPHABET.index(c)}
    y = x.zip(shift.cycle(4)).map(&:sum)
    z = y.map {|c| ALPHABET[c % 27]} 
    a = z.join("")

    encrypt = {}
    encrypt["encryption".to_sym] = a
    encrypt["key".to_sym] = key
    encrypt["date".to_sym] = date
    encrypt
  end

  def decrypt(code, key, date)
    last_4_of_date(date)
    key_decrypt_values(key)
    combined_shift = last_4_of_date(date).zip(@key_decrypt_arrays)
    shift = combined_shift.map do |shift|
      shift.sum
    end
    x = message.chars.map {|c| ALPHABET.index(c)}
    y = x.zip(shift.cycle(4)).map(&:sum)
    z = y.map {|c| ALPHABET[c % 27]} 
    a = z.join("")

    encrypt = {}
    encrypt["encryption".to_sym] = a
    encrypt["key".to_sym] = key
    encrypt["date".to_sym] = date
    encrypt
  end

  def last_4_of_date(date)
    squared = date.to_i**2
    last_4_string = squared.to_s.chars.last(4)
    last_4_string.map do |integer|
      integer.to_i
    end
  end

  def key_encrypt_values(key)
    key.chars.each_cons(2) do |number_set|
      @key_encrypt_arrays <<  number_set.join.to_i
    end
  end

  def key_decrypt_values(key)
    key.chars.each_cons(2) do |number_set|
      @key_decrypt_arrays <<  number_set.join.to_i
    end
  end
end