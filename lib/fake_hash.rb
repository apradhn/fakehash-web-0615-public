require "pry"

class FakeHashWrapper
  attr_accessor :hash

  def initialize
    @hash = {}
    @keys = []
  end

  def []=(key, value)
    @hash[key] = value
    @keys << key
  end

  def [](key)
    if @keys.include?(key)
      hash[key]
    elsif @keys.include?(key.to_s)
      hash[key.to_s]
    elsif @keys.include?(key.to_sym)
      hash[key.to_sym]
    end
  end

  def keys
    @keys.sort{|a, b| b <=> a}
  end

  def first_letter(letter)
    @hash.select {|key, value| key.to_s[0] == letter}.collect{|key, value| value}
  end

  def each
    @hash.each do |key, value|
      yield(key, value)
    end
  end

end