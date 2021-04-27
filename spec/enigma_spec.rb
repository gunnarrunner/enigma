require './lib/enigma'
require 'date'


RSpec.describe Enigma do
  it 'exists' do
    enigma = Enigma.new

    expect(enigma).to be_instance_of(Enigma)
  end

  it 'can encrypt a message with a key and date' do
    enigma = Enigma.new

    expected = {
                encryption: "keder ohulw",
                key: "02715",
                date: "040895"
                }

    expect(enigma.encrypt("HelLo WoRld", "02715", "040895")).to eq(expected)
  end

  it 'can decrypt a message with a key and date' do
    enigma = Enigma.new

    expected = {
                decryption: "hello world",
                key: "02715",
                date: "040895"
                }

    expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
  end

  it 'can encrypt a message with a key and no date' do
    Enigma.any_instance.stub(:default_date).and_return("040296")

    enigma = Enigma.new

    expected = {
                encryption: "qkcfx",
                key: "02715",
                date: "040296"
                }

    expect(enigma.encrypt("hello", "02715")).to eq(expected)
  end

  it 'can decrypt a message with a key and not a date' do
    Enigma.any_instance.stub(:default_date).and_return("040296")
    
    enigma = Enigma.new

    expected = {
                decryption: "hello",
                key: "02715",
                date: "040296"
                }

    expect(enigma.decrypt("qkcfx", "02715")).to eq(expected)
  end

  it 'can encrypt a message without a key and a date' do
    Enigma.any_instance.stub(:key_encrypt_values).and_return([1,2,3,4])
    Enigma.any_instance.stub(:key_encrypt_arrays).and_return([5,6,7,8])
    Enigma.any_instance.stub(:default_key).and_return("12345")
    Enigma.any_instance.stub(:default_date).and_return("040296")

    enigma = Enigma.new

    expected = {
                encryption: "tqtz " ,
                key: "12345",
                date: "040296"
                }

      enigma.key_encrypt_arrays = [5,6,7,8]
      
      expect(enigma.encrypt("hello")).to eq(expected)
  end
end