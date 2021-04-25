class Enigma
ALPHABET = ("a".."z").to_a << " "

  attr_reader :key_arrays
  def initialize
      @key_arrays = []
  end

  def encrypt(message, key, date)
    last_4_of_date(date)
    key_values(key)
    combined_shift = last_4_of_date(date).zip(key_arrays)
    shift = combined_shift.map do |shift|
      shift.sum
    end
    require "pry"; binding.pry
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
      @key_arrays <<  number_set.join.to_i
    end
  end
end