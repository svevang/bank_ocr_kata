require "bank_ocr_kata/version"

# Reads multicharacter digit representations.

module BankOcrKata
  module Digits
    def self.read(path)
      contents = File.read(path)
    end
  end
end
