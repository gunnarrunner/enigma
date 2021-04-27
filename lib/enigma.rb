require 'date'


class Enigma
ALPHABET = ("a".."z").to_a << " "

  attr_accessor :keys_array
  def initialize
      @keys_array = []
  end

  def encrypt(message, key = default_key, date = default_date)
    # last_4_of_date(date)
    # key_values(key)

    # combined_shift = last_4_of_date(date).zip(@keys_array)

    # shift = combined_shift.map do |shift|
    #   shift.sum
    # end

    # indexed_message = message.downcase.chars.map do |message_letter|
    #   if ALPHABET.index(message_letter) == nil
    #     message_letter
    #   else
    #     ALPHABET.index(message_letter)
    #   end
    # end
    
    # shifted_message_index_not_summed = indexed_message.zip(shift.cycle)
    
    # shifted_message_index = shifted_message_index_not_summed.map do |index|
    #   if index[0].instance_of?(String)
    #     index[0]
    #   else
    #     index.sum
    #   end
    # end

    # seperated_encrypted_message = shifted_message_index.map do |new_index_number|
    #   if new_index_number.instance_of?(String)
    #     new_index_number
    #   else
    #     ALPHABET[new_index_number % 27]
    #   end
    # end


    # encrypted_message = seperated_encrypted_message.join("")

    # encrypt = {}
    # encrypt["encryption".to_sym] = encrypted_message
    # encrypt["key".to_sym] = key
    # encrypt["date".to_sym] = date
    # encrypt
    crypt(message, key, date, "encrypt")
  end

  def decrypt(code, key = default_key, date = default_date)
    # last_4_of_date(date)
    # key_values(key)
    
    # combined_shift = last_4_of_date(date).zip(@keys_array)

    # shift = combined_shift.map do |shift|
    #   shift.sum
    # end

    # negative_shift = shift.map do |shift| 
    #   shift * -1
    # end

    # indexed_message = code.chars.map do |encrypt_letter|
    #   if ALPHABET.index(encrypt_letter) == nil
    #     encrypt_letter
    #   else
    #     ALPHABET.index(encrypt_letter)
    #   end
    # end

    # shifted_message_index_not_summed = indexed_message.zip(negative_shift.cycle)
    
    # shifted_message_index = shifted_message_index_not_summed.map do |index|
    #   if index[0].instance_of?(String)
    #     index[0]
    #   else
    #     index.sum
    #   end
    # end

    # seperated_encrypted_message = shifted_message_index.map do |new_index_number|
    #   if new_index_number.instance_of?(String)
    #     new_index_number
    #   else
    #     ALPHABET[new_index_number % 27]
    #   end
    # end

    # encrypted_message = seperated_encrypted_message.join("")

    # encrypt = {}
    # encrypt["decryption".to_sym] = encrypted_message
    # encrypt["key".to_sym] = key
    # encrypt["date".to_sym] = date
    # encrypt
    crypt(code, key, date, "decrypt")
  end

  def crypt(code, key = default_key, date = default_date, type)
    last_4_of_date(date)
    key_values(key)
    
    combined_shift = last_4_of_date(date).zip(@keys_array)

    shift = combined_shift.map do |shift|
      shift.sum
    end

    if type == "decrypt"
      shift = shift.map do |shift| 
        shift * -1
      end
    end

    indexed_message = code.downcase.chars.map do |encrypt_letter|
      if ALPHABET.index(encrypt_letter) == nil
        encrypt_letter
      else
        ALPHABET.index(encrypt_letter)
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

    seperated_encrypted_message = shifted_message_index.map do |new_index_number|
      if new_index_number.instance_of?(String)
        new_index_number
      else
        ALPHABET[new_index_number % 27]
      end
    end

    encrypted_message = seperated_encrypted_message.join("")

    if type == "encrypt"
      encrypt = {}
      encrypt["encryption".to_sym] = encrypted_message
      encrypt["key".to_sym] = key
      encrypt["date".to_sym] = date
      encrypt
    elsif
      decrypt = {}
      decrypt["decryption".to_sym] = encrypted_message
      decrypt["key".to_sym] = key
      decrypt["date".to_sym] = date
      decrypt
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