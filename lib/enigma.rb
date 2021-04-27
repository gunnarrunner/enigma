require 'date'


class Enigma
ALPHABET = ("a".."z").to_a << " "

  attr_accessor :key_encrypt_arrays,
                :key_decrypt_arrays
  def initialize
      @key_encrypt_arrays = []
      @key_decrypt_arrays = []
  end

  def encrypt(message, key = default_key, date = default_date)
    last_4_of_date(date)
    key_encrypt_values(key)

    combined_shift = last_4_of_date(date).zip(@key_encrypt_arrays)

    shift = combined_shift.map do |shift|
      shift.sum
    end

    indexed_message = message.downcase.chars.map do |c|
      if ALPHABET.index(c) == nil
        c
      else
        ALPHABET.index(c)
      end
    end
    
    shifted_message_index_not_summed = indexed_message.zip(shift.cycle)
    
    shifted_message_index = shifted_message_index_not_summed.map do |index|
      if index[0].instance_of?(String)
        index[0]
      else
        index.sum
      end
    end

    seperated_encrypted_message = shifted_message_index.map do |c|
      if c.instance_of?(String)
        c
      else
        ALPHABET[c % 27]
      end
    end


    encrypted_message = seperated_encrypted_message.join("")

    encrypt = {}
    encrypt["encryption".to_sym] = encrypted_message
    encrypt["key".to_sym] = key
    encrypt["date".to_sym] = date
    encrypt
  end

  def decrypt(code, key = default_key, date = default_date)
    last_4_of_date(date)
    key_decrypt_values(key)
    
    combined_shift = last_4_of_date(date).zip(@key_decrypt_arrays)

    shift = combined_shift.map do |shift|
      shift.sum
    end

    negative_shift = shift.map do |shift| 
      shift * -1
    end

    indexed_message = code.chars.map do |c|
      if ALPHABET.index(c) == nil
        c
      else
        ALPHABET.index(c)
      end
    end

    shifted_message_index_not_summed = indexed_message.zip(negative_shift.cycle)
    
    shifted_message_index = shifted_message_index_not_summed.map do |index|
      if index[0].instance_of?(String)
        index[0]
      else
        index.sum
      end
    end

    seperated_encrypted_message = shifted_message_index.map do |c|
      if c.instance_of?(String)
        c
      else
        ALPHABET[c % 27]
      end
    end

    encrypted_message = seperated_encrypted_message.join("")

    encrypt = {}
    encrypt["decryption".to_sym] = encrypted_message
    encrypt["key".to_sym] = key
    encrypt["date".to_sym] = date
    encrypt
  end

  def default_date
    date_now = Time.now
    date = date_now.strftime("%d%m%y")
  end

  def default_key
    key = rand(1..99999).to_s.rjust(5, "0")
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
    @key_encrypt_arrays << number_set.join.to_i
    end
  end

  def key_decrypt_values(key)
    key.chars.each_cons(2) do |number_set|
      @key_decrypt_arrays << number_set.join.to_i
    end
  end
end