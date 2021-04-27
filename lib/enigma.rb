require 'date'

class Enigma
ALPHABET = ("a".."z").to_a << " "

  attr_accessor :keys_array
  def initialize
      @keys_array = []
  end

  def encrypt(message, key = default_key, date = default_date)
    crypt(message, key, date, "encrypt")
  end

  def decrypt(code, key = default_key, date = default_date)
    crypt(code, key, date, "decrypt")
  end

  def crypt(code, key = default_key, date = default_date, type)
    last_4_of_date(date)
    key_values(key)
    
    combined_shift = last_4_of_date(date).zip(@keys_array)

    shift = combined_shift.map(&:sum) 

    if type == "decrypt"
      shift = shift.map do |shift| 
        shift * -1
      end
    end

    indexed_message = downcase_and_index_message(code)

    shifted_message_index_not_summed = indexed_message.zip(shift.cycle)
    
    shifted_message_index = not_summed_shift_message(shifted_message_index_not_summed)

    seperated_encrypted_message = shift_message_index(shifted_message_index)

    message = seperated_encrypted_message.join("")

    if type == "encrypt"
      encrypt = {}
      encrypt[:encryption] = message
      encrypt[:key] = key
      encrypt[:date] = date
      encrypt
    elsif type == "decrypt"
      decrypt = {}
      decrypt[:decryption] = message
      decrypt[:key] = key
      decrypt[:date] = date
      decrypt
    end
  end

  def shift_message_index(shift_index)
    shift_index.map do |new_index_number|
      if new_index_number.instance_of?(String)
        new_index_number
      else
        ALPHABET[new_index_number % 27]
      end
    end
  end

  def not_summed_shift_message(zipped_message)
    zipped_message.map do |index|
      if index[0].instance_of?(String)
        index[0]
      else
        index.sum
      end
    end
  end

  def downcase_and_index_message(code)
    code.downcase.chars.map do |encrypt_letter|
      if ALPHABET.index(encrypt_letter) == nil
        encrypt_letter
      else
        ALPHABET.index(encrypt_letter)
      end
    end
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

  def key_values(key)
    key.chars.each_cons(2) do |number_set|
    @keys_array << number_set.join.to_i
    end
  end
end